module Rack
  module Banken
    class ExceptionHandler

      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          @app.call(env)

        rescue Exceptions::Base => e
          raise e.class, e.message

        rescue => e
          raise Exceptions::InternalServerError, e.message
        end

      rescue  Exceptions::Base => exception
        exception.to_rack_response
      end
    end
  end
end
