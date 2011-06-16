$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'changelog/file'
require 'changelog/gem_specification_extension'
require 'changelog/stats'

module Changelog
  VERSION = '0.0.1'
end

Gem::Specification.send(:include, Changelog::GemSpecificationExtension)
