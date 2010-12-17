module Sequel
  module Schema
    class Column
      attr_accessor :name, :type, :default
      attr_writer   :allow_null
      
      def initialize(name, type, opts={})
        @name = name.to_sym
        @type = type.to_sym
        @allow_null = opts[:allow_null]
        @default    = opts[:default]
      end

      def self.build(name, type, opts={})
        new(name, type, opts)
      end

      # Returns true if this column can have null values.
      def allow_null?
        !! @allow_null
      end
    end
  end
end
