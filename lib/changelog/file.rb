module Changelog

  class File

    RE_SUBDIRS   = /(docs?\/)/i
    RE_FILENAMES = /(history|changelog|changes)/i
    RE_SUFFIX    = /(?:\..+)/i
    RE_CHANGELOG = /^#{RE_SUBDIRS}?#{RE_FILENAMES}#{RE_SUFFIX}?$/i

    def initialize(spec)
      @spec = spec
    end

    def name
      @name ||= ambiguous? ? nil : candidates.first
    end

    def path
      return nil if name.nil?
      ::File.join(@spec.gem_dir, name)
    end

    def content
      return nil if path.nil?
      ::File.read(path)
    end

    def ambiguous?
      candidates.size > 1
    end

    def missing?
      candidates.empty?
    end

    def candidates
      @candidates ||= find(@spec.files)
    end

    def find(filelist)
      filelist.find_all {|fn| fn =~ RE_CHANGELOG }
    end

  end

end
