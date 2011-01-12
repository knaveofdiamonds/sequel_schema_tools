module Sequel
  module Schema
    # An index in the database.
    class Index
      # The name of the index.
      attr_reader :name

      # Returns an array of columns of this index covers.
      attr_reader :columns
      
      def initialize(name, columns, unique = false)
        @name = name.to_sym
        @columns = columns.kind_of?(Array) ? columns.clone : [columns]
        @unique = unique
      end

      def primary_key?
        false
      end
      
      # Returns true if this index is a unique index.
      def unique?
        !! @unique
      end

      # Returns true if this index is a multi-column index
      def multi_column?
        @columns.size > 1
      end

      def ==(other)
        other.kind_of?(self.class) &&
          @name == other.name && @columns == other.columns && @unique == other.unique?
      end
      alias :eql? :==
      
      def hash
        @name.hash
      end
    end

    class PrimaryKey < Index
      def initialize(columns)
        super(:PRIMARY, columns, true)
      end

      def primary_key?
        true
      end
    end
  end
end
