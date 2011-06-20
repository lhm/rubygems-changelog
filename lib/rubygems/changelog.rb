$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'changelog/file'
require 'changelog/gem_specification_extension'
require 'changelog/stats'

# Gem::Specification.send(:include, Gem::Changelog::GemSpecificationExtension)
