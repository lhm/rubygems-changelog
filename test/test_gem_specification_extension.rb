require 'helper'

class TestGemSpecificationExtension < MiniTest::Unit::TestCase

  def setup
    Gem::Specification.send(:include, Changelog::GemSpecificationExtension)
    @spec_path = File.join(File.dirname(__FILE__), 'fixtures', 'testspec-good.gemspec')
    @spec = Gem::Specification.load(@spec_path)
  end

  def test_extension_loaded
    assert_respond_to @spec, :changelog
  end

  def test_changelog_returns_file
    assert_kind_of Changelog::File, @spec.changelog
  end

  def test_changelog_working
    @spec.changelog.stubs(:installed_files => ["History.txt", "lib/foo.rb"])
    assert_equal 'History.txt', @spec.changelog.name
    assert_equal false, @spec.changelog.ambiguous?
  end

end
