module Rack
  module Banken
    # Base class for providing some utility methods to handle Rack env and Banken::DSL
    class BaseRequestHandler

      def self.call(**args)
        new(**args).call
      end

      def initialize(env: nil, dsl: nil)
        @env = env
        @dsl = dsl
      end

      private

      def request
        @request || Rack::Request.new(@env)
      end

      def method
        request.request_method
      end

      def path
        request.path_info
      end

      def params
        request.params
      end

      def dsl_requests_for_current_request
        dsl_requests_for_current_method(dsl_requests_for_current_path).first
      end

      def dsl_requests_for_current_path(dsl_requests = nil)
        if dsl_requests == nil
          dsl_requests = @dsl.requests
        end
        dsl_requests.select { |r| r.path == path }
      end

      def dsl_requests_for_current_method(dsl_requests = nil)
        if dsl_requests == nil
          dsl_requests = @dsl.requests
        end
        dsl_requests.select { |r| r.method == method }
      end

    end
  end
end
