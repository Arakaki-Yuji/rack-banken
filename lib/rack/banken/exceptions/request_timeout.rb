module Rack
  module Banken
    module Exceptions
      class RequestTimeout < Base

        private

        def status_code
          408
        end
      end
    end
  end
end
