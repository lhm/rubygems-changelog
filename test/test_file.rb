require 'helper'
require 'tmpdir'

class TestFile < MiniTest::Unit::TestCase

  def setup
    @spec = stub()
    @cf   = Gem::Changelog::File.new(@spec)
  end

  def test_initialization
    assert_raises ArgumentError do
      Gem::Changelog::File.new
    end
  end

  def test_name
    @cf.stubs(:installed_files => %w(foo.rb bar.rb History.txt))
    assert_equal "History.txt", @cf.name
  end

  def test_name_returns_nil_if_missing
    @cf.stubs(:installed_files => %w(foo bar))
    assert_equal nil, @cf.name
  end

  def test_find_file_detects_common_names
    %w(History.txt History Changelog CHANGELOG changelog CHANGES changes).each do |name|
      assert_equal [name], @cf.find( ["foo.rb", "bar.rb", ".autotest", name] )
    end
  end

  def test_find_ignores_files_in_nonroot_dirs
    files = ["lib/CHANGELOG"]
    assert_equal [], @cf.find(files)
  end

  def test_find_ignores_irrelevant_name_parts
    files = ["some_changes", "object_history.rb", "changes_class"]
    assert_equal [], @cf.find(files)
  end

  def test_find_returns_multiple_matches
    files = %w(History Changelog)
    assert_equal ["History", "Changelog"], @cf.find(files)
  end

  def test_ambiguous_returns_true_if_more_than_one_candidate
    files = %w(History Changelog)
    @cf.stubs(:installed_files => files)
    assert @cf.ambiguous?
  end

  def test_ambiguous_returns_false_if_no_match
    files = %w(foo bar)
    @cf.stubs(:installed_files => files)
    assert_equal false, @cf.ambiguous?
  end

  def test_missing
    files = %w(foo bar)
    @cf.stubs(:installed_files => files)
    assert @cf.missing?
  end

  def test_path
    files  = %w(History.txt)
    gemdir = '/Library/Ruby/Gems/1.8/gems/mygem-0.1.0'
    @cf.stubs(:installed_files => files)
    @spec.stubs(:gem_dir => gemdir)
    assert_equal "#{gemdir}/History.txt", @cf.path
  end

  def test_content
    path = "/some/path/history.txt"
    the_content = "This is the Changelog Content"
    @cf.stubs(:path => path)
    File.expects(:read).with(path).returns(the_content)
    assert_equal the_content, @cf.content
  end

  def test_regex_matches_good_names
    %w(
      changelog
      Changelog
      ChangeLog
      CHANGELOG
      Changelog.txt
      Changes
      History.txt
      History.rdoc
      doc/CHANGELOG
      docs/CHANGELOG
    ).each do |filename|
      assert_match Gem::Changelog::File::RE_CHANGELOG, filename
    end
  end

  def test_regex_does_not_match_bad_names
    %w(
      foo
      bar.rb
      .
      ..
      xxx_history.txt
      history_xxx.txt
      yyy_history_xxx.txt
      yyy_history_xxx
      lib/CHANGELOG
      lib/changelog.rdoc
      .changes
      foo.changes
    ).each do |filename|
      refute_match Gem::Changelog::File::RE_CHANGELOG, filename
    end

  end

  def test_installed_files
    gem_path = "gemdir/mygem-0.1.0"
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        FileUtils.mkdir_p File.join(gem_path, "lib")
        File.open(File.join(gem_path, "CHANGELOG"), 'w+') {|f| f << "Changelog content"}

        @spec.stubs(:gem_dir => gem_path)
        assert_equal ["CHANGELOG"], @cf.installed_files
      end
    end
  end

end
