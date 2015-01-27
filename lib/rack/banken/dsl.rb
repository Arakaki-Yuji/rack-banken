module Rack
  module Banken
    class DSL

      @@requests = []
      @@responses = []

      def self.request(path: , method: , &block)
        request = Request.new(path, method)
        request.instance_eval &block

        @@requests << request
      end

      def self.response(path: , method: , &block)
        response = Response.new(path, method)
        response.instance_eval &block

        @@responses << response
      end

      def self.requests
        @@requests
      end

      def self.responses
        @@responses
      end

    end

    class Request
      attr_accessor :path, :method
      attr_reader :description, :properties

      def initialize(path, method)
        self.path = path
        self.method = method
        @properties = []
      end

      def description(desc)
        @description = desc
      end

      def property(name, &block)
        property = Property.new(name)
        property.instance_eval &block
        @properties << property
      end

    end

    class Response

      attr_accessor :path, :method
      attr_reader :description, :properties

      def initialize(path, method)
        self.path = path
        self.method = method
        @properties = []
      end

      def description(desc)
        @description = desc
      end

      def property(name, &block)
        property = Property.new(name)
        property.instance_eval &block

        @properties << property
      end

    end

    class Property
      attr_accessor :name
      attr_reader :description, :example, :type, :regexp

      def initialize(name)
        self.name = name
      end

      def description(desc)
        @description = desc
      end

      def example(example)
        @example = example
      end

      def type(type)
        @type = type
      end

      def regexp(regexp_str)
        @regexp = regexp_str
      end
    end
  end
end
