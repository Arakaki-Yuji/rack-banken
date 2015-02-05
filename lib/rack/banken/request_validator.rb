module Rack
  module Banken
    class RequestValidator

      def initialize(app, dsl)
        @app = app
        @dsl = dsl
      end

      def call(env)
        Validator.call(env: env, dsl: @dsl)
        @app.call(env)
      end

    end

    class Validator < BaseRequestHandler
      include Rack::Banken::Validation::TypeCheck

      def self.call(**args)
        new(**args).call
      end

      def initialize(env: nil, dsl: nil)
        @env = env
        @dsl = dsl
      end

      def call

        if dsl_requests_for_current_request != nil
          unless has_required_params?
            raise Exceptions::ValidationFailed, 'is not contain required params'
          end
          unless value_type_is_valid?
            raise Exceptions::ValidationFailed
          end
        end
      end

      private

      def value_type_is_valid?
        params.each do |key, value|
          property = dsl_requests_for_current_request.find_by_property_by_name(key)
          if valid_type?(property.get_type, value) == false
            return false
          end
        end
        true
      end

      def valid_type?(type, value)
        case type
        when :integer
          return integer?(value)
        when :number
          return number?(value)
        when :string
          return string?(value)
        when :datetime
          return datetime?(value)
        when :file
          return file?(value)
        else
          true
        end
      end

      def has_required_params?
        required_property_names = dsl_requests_for_current_request.required_properties.map do |p|
          p.name.to_s
        end

        if required_property_names.count == 0
          return true
        end

        required_property_names.each do |p|
          if params.keys.include?(p) == false
            return false
          end
        end

        true
      end
    end

  end
end
