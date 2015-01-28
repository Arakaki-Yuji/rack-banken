module Rack
  module Banken
    module Exceptions
      class RequestEntityTooLarge < Base

        private

        def status_code
          413
        end
      end
    end
  end
end
