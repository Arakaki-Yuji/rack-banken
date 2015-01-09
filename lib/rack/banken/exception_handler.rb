module Rack
  module Banken
    class ExceptionHandler

      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          @app.call(env)

        rescue Exceptions::ValidationFailed => e
          raise Exceptions::ValidationFailed, e.message

        rescue => e
          raise Exceptions::InternalServerError, e.message
        end

      rescue  Exceptions::Base => exception
        exception.to_rack_response
      end
    end
  end
end
