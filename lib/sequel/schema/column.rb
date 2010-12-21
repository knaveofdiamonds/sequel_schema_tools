module Sequel
  module Schema
    # A column in a database table.
    class Column
      # The name of this column.
      attr_accessor :name

      # The database type of this column, as usable in a Sequel
      # Migration statement.
      #
      # Not necessarily exactly the same as the database type string -
      # for example a :boolean column will be a tinyint(1) in MySQL.
      attr_accessor :type

      # The default value for this column. Will be a Ruby type where
      # possible, otherwise a String).
      attr_accessor :default

      # Sets whether null is allowed in this column.
      attr_writer   :allow_null

      # Creates a new Column.
      def initialize(name, type, opts={})
        @name = name.to_sym
        @type = type.to_sym
        @allow_null = opts[:allow_null]
        @default    = set_default(opts[:default])
      end

      # Returns true if this column can have null values.
      def allow_null?
        !! @allow_null
      end

      protected

      # Sets the default for this column.
      #
      # May be overriden by subclasses.
      def set_default(default)
        @default = default
      end
    end

    # A numeric column, such as an integer or float.
    class NumericColumn < Column
      # Sets whether this column is unsigned.
      attr_writer :unsigned

      # Returns whether this column is unsigned
      def unsigned?
        !! @unsigned
      end

      def initialize(name, type, opts={})
        super
        @unsigned = !! opts[:unsigned]
      end
    end

    # A textual column such as a varchar or text.
    class TextualColumn < Column
      # Returns the maximum length of this column.
      attr_accessor :size

      # Returns the character set of this column.
      #
      # May return nil, in which case the column has the table's
      # default character set.
      attr_accessor :charset

      def initialize(name, type, opts={})
        super
        @size = opts[:size] || 255
        @charset = opts[:charset]
      end
    end

    # An enumerated column, such as an Enum or Set (in MySQL).
    class EnumeratedColumn < Column
      attr_reader :elements

      def initialize(name, type, opts={})
        super
        @elements = opts[:elements] || []
      end
    end
  end
end
