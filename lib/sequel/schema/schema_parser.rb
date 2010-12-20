module Sequel
  module Schema
    class SchemaParser
      # Returns an appropriate schema parser for the database
      # connection.
      def self.for_db(db)
        new(db)
      end

      # Returns a Column given a column details array as returned by
      # DB.schema.
      def parse_column(column_definition)
        name, hsh = *column_definition

        options = {}
        options[:default] = hsh[:ruby_default] || hsh[:default]
        options[:allow_null] = hsh[:allow_null]
        
        Column.new(name, parse_type(hsh[:db_type]), options)
      end

      protected

      # Creates a new schema parser for the given database
      # connection. Use for_db instead.
      def initialize(db)
        @db = db
      end

      # Returns a type symbol for a given db_type string, suitable for
      # use in a Sequel migration.
      #
      # Examples:
      #
      #    parse_type("int(11)")     # => :integer
      #    parse_type("varchar(20)") # => :varchar
      #
      def parse_type(type)
        case type
        when /^int/          then :integer
        when /^tinyint\(1\)/ then :boolean
        when /^([^(]+)/      then $1.to_sym
        end
      end
    end
  end
end
