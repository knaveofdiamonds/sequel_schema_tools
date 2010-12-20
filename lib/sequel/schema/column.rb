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
  end
end
