require 'rubygems/command'
require 'rubygems/version_option'

require 'rubygems/changelog'

#
# gem command for displaying the changelog or history file of an installed gem
#
class Gem::Commands::ChangelogCommand < Gem::Command

  include Gem::VersionOption

  def initialize
    super 'changelog',
          'Display the changelog file of a gem',
          :version => Gem::Requirement.default

    add_version_option
  end

  def arguments # :nodoc:
    'GEMNAME       name of an installed gem'
  end

  def defaults_str # :nodoc:
    "--version='>= 0'"
  end

  def usage # :nodoc:
    "#{program_name} GEMNAME [options]"
  end

  def execute
    name = get_one_gem_name
    spec = Gem::Specification.find_by_name name, options[:version]
    changelog = Gem::Changelog::File.new(spec)

    if changelog.missing?
      say "No changelog file found for gem: #{spec.name} #{spec.version}"
      terminate_interaction 1
    elsif changelog.ambiguous?
      say "Multiple possible changelog files found for gem: #{spec.name} #{spec.version}:"
      changelog.candidates.each {|cname| say cname}
      terminate_interaction 1
    else
      say changelog.content
    end

  end


end

