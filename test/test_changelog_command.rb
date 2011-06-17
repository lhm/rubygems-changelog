require 'helper'
require 'rubygems/test_case'
require 'rubygems/commands/changelog_command'

class TestChangelogCommand < Gem::TestCase

  def setup
    super

    @cmd = Gem::Commands::ChangelogCommand.new
  end

  def test_execute
    name = "mygem"
    spec = quick_gem name do |gem|
      gem.files = %W[lib/#{name}.rb Changelog]
    end
    write_file File.join(*%W[gems #{spec.full_name} lib #{name}.rb])
    write_file(File.join(*%W[gems #{spec.full_name} Changelog])) {|f| f << "This is the Changelog"}

    @cmd.options[:args] = [name]

    use_ui @ui do
      @cmd.execute
    end

    assert_equal "This is the Changelog\n", @ui.output
    assert_equal "", @ui.error

  end

end
