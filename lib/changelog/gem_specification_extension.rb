module Changelog

  module GemSpecificationExtension

    def changelog
      @changelog ||= Changelog::File.new(self)
    end

  end

end
