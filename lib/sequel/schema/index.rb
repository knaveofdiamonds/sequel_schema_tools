module Sequel
  module Schema
    # Implementation of most Index/Primary Key methods.
    module IndexMethods
      # The name of the index.
      attr_reader :name

      # Returns an array of columns of this index covers.
      attr_reader :columns

      def initialize(name, columns, unique = false)
        @name = name.to_sym
        @columns = columns.kind_of?(Array) ? columns.clone : [columns]
        @unique = unique
      end      

      # Returns true if this index is a unique index.
      def unique?
        !! @unique
      end

      # Returns true if this index is a multi-column index
      def multi_column?
        @columns.size > 1
      end

      # Indexes are equal if all their attributes are equal.
      def ==(other)
        other.kind_of?(self.class) &&
          @name == other.name && @columns == other.columns && @unique == other.unique?
      end
      alias :eql? :==
      
      def hash
        @name.hash
      end
    end
    
    # An index in the database.
    class Index
      include IndexMethods

      # Returns a Hash representation of this index, in the same
      # format as calling Sequel::Database#indexes
      def to_hsh
        {name => {:columns => columns, :unqiue => unique}}
      end
    end

    class PrimaryKey
      include IndexMethods
      
      def initialize(columns)
        super(:PRIMARY, columns, true)
      end
    end
  end
end
