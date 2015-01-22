module Rack
  module Banken
    module Exceptions
      class RequestUriTooLong < Base

        private

        def status_code
          414
        end
      end
    end
  end
end
