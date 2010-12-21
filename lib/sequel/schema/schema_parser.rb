module Sequel
  module Schema
    class SchemaParser
      # Returns an appropriate schema parser for the database
      # connection.
      def self.for_db(db)
        new(db, ColumnParser.new)
      end

      # Returns a hash of {table_name => Table} for the current
      # database connection.
      def parse_db_schema
        Hash.new(@table.tables.map {|table_name| [table_name, parse_table(table_name)] })
      end

      # Returns a table based on introspecting the Database schema.
      def parse_table(name)
        table = Table.new(name)
        @db.schema(table_name).each {|c| table.columns << @column_parser.parse(c) }
        table
      end

      protected
      
      # Creates a new schema parser for the given database
      # connection. Use for_db instead.
      def initialize(db, column_parser)
        @column_parser = column_parser
        @db = db
      end
    end
  end
end
