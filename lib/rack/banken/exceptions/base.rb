module Rack
  module Banken
    module Exceptions
      class Base < StandardError
        def to_rack_response
          [status_code, headers, [body]]
        end

        private

        def status_code
          500
        end

        def headers
          { "Content-Type" => "application/json" }
        end

        def body
          { result: false, error: error_message }.to_json
        end

        def error_message
          self.message
        end

        def type
          self.class.to_s.split("::").last.underscore
        end
      end
    end
  end
end
