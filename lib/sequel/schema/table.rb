module Sequel
  module Schema
    class Table
      attr_accessor :name

      attr_reader :columns

      attr_reader :indexes

      attr_reader :options
      
      def initialize(name, options={})
        @name = name
        @options = options
        @columns = []
        @indexes = []
      end
    end
  end
end
