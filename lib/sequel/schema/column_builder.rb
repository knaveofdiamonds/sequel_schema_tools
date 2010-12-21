module Sequel
  module Schema
    class ColumnParser
      attr_reader :numeric_types, :enumerated_types, :textual_types

      def initialize
        @numeric_types = [:tinyint, :smallint, :mediumint, :bigint, :integer, :float, :double, :decimal].freeze
        @enumerated_types = [:enum, :set].freeze
        @textual_types = [:char, :varchar, :text, :tinytext, :mediumtext, :longtext].freeze
      end

      def parse(column_definition)
        name, hsh = *column_definition
        type = parse_type(hsh[:db_type])
        
        options = {}
        options[:default] = hsh[:ruby_default] || hsh[:default]
        options[:allow_null] = hsh[:allow_null]

        if type == NumericColumn
          options[:unsigned] = hsh[:db_type].include?("unsigned")
        end

        if type == EnumeratedColumn
          match = db_type_string.match(/\((.+)\)/)
          options[:elements] = eval('[' + match[1] + ']') if match[1]
        end
        
        column_class(type).new(name, type, options)
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

      # Returns a Column class given the type.
      def column_class(type)
        if numeric_types.include?(type) then NumericColumn
        elsif enumerated_types.include?(type) then EnumeratedColumn
        elsif textual_types.include?(type) then TextualColumn
        else
          Column
        end
      end
    end
  end
end
