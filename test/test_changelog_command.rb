require 'helper'
require 'rubygems/test_case'
require 'rubygems/commands/changelog_command'

class TestChangelogCommand < Gem::TestCase

  def setup
    super

    @cmd = Gem::Commands::ChangelogCommand.new
  end

  def gem_with_files(name, filelist)
    spec = quick_gem name do |gem|
      gem.files = filelist
    end
    spec.files.each do |filename|
      write_file(File.join(*%W[gems #{spec.full_name} #{filename}])) {|f| f << "##{filename}"}
    end
    spec
  end

  def test_execute
    name = "mygem"
    gem_with_files name, %w(lib/myname.rb Changelog)

    @cmd.options[:args] = [name]

    use_ui @ui do
      @cmd.execute
    end

    assert_equal "#Changelog\n", @ui.output
    assert_equal "", @ui.error
  end

  def test_execute_ambiguous
    name = "mygem"
    files = %w(Changelog History.txt)
    gem_with_files name, files

    @cmd.options[:args] = [name]

    use_ui @ui do
      assert_raises Gem::MockGemUi::TermError do
        @cmd.execute
      end
    end

    assert_match "Multiple possible changelog files found", @ui.output
    assert_match "Changelog", @ui.output
    assert_match "History.txt", @ui.output

  end

end
