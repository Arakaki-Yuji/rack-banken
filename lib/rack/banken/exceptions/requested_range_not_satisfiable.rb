module Rack
  module Banken
    module Exceptions
      class RequestedRangeNotSatisfiable < Base

        private

        def status_code
          416
        end
      end
    end
  end
end
