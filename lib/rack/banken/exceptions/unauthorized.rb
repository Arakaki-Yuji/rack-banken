module Rack
  module Banken
    module Exceptions
      class Unauthorized < Base

        private

        def status_code
          401
        end
      end
    end
  end
end
