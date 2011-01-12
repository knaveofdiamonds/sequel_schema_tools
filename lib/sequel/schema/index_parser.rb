module Sequel
  module Schema
    class IndexParser
      def parse(indexes)
        indexes.map do |key, value|
          Index.new(key, value[:columns], value[:unique])
        end
      end
    end
  end
end
