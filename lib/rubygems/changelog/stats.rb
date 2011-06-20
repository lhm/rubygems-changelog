module Gem

  module Changelog

    class Stats

      DEFAULT_PATH = '/Library/Ruby/Gems/1.8'

      def initialize(path=DEFAULT_PATH)
        Gem::Specification.dirs = [path]
      end

      def names
        counter = Hash.new {|h,k| h[k] = 0}
        specs.inject(counter) do |c, spec|
          name = if spec.changelog.missing?
                   "missing"
                 elsif spec.changelog.ambiguous?
                   puts "%s => %s" % [spec.name, spec.changelog.candidates.inspect]
                   "ambiguous"
                 else
                   spec.changelog.name
                 end
          c[name] += 1
          c
        end
      end

      def missing
        specs.
          select {|spec| spec.changelog.missing? }.
          map(&:name)
      end

      def ambiguous
        specs.
          select {|spec| spec.changelog.ambiguous? }.
          map    {|spec| [spec.name, spec.changelog.candidates] }
      end

      def specs
        @specs ||= Gem::Specification.all
      end


    end


  end

end
