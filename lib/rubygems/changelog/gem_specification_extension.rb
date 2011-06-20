module Gem

  module Changelog

    module GemSpecificationExtension

      def changelog
        @changelog ||= Gem::Changelog::File.new(self)
      end

    end

  end

end
