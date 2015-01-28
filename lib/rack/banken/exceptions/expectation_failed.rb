module Rack
  module Banken
    module Exceptions
      class ExpectationFailed < Base

        private

        def status_code
          417
        end
      end
    end
  end
end
