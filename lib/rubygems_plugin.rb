require 'rubygems/command_manager'

module Gem
  module Changelog
    VERSION = '0.0.2'
  end
end

Gem::CommandManager.instance.register_command :changelog
