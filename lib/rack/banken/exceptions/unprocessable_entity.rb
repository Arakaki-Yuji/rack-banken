module Rack
  module Banken
    module Exceptions
      class UnprocessableEntity < Base

        private

        def status_code
          422
        end
      end
    end
  end
end
