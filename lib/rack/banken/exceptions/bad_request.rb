module Rack
  module Banken
    module Exceptions
      class BadRequest < Base

        private

        def status_code
          400
        end
      end
    end
  end
end
