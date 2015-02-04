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
            raise Exceptions::ValidationFailed
          end
        end
      end

      private

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
