module Sequel
  module Schema
    class Table
      # The name of this table
      attr_accessor :name

      # The columns of this table
      attr_reader :columns

      # The non-primary key indexes of this table
      attr_reader :indexes

      # Any table options.
      attr_reader :options
      
      # Creates a new table definition
      def initialize(name, options={})
        @name = name.to_sym
        @options = options
        @columns = []
        @indexes = []
      end
    end
  end
end
