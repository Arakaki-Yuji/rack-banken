module Rack
  module Banken
    module Exceptions
      class Conflict < Base

        private

        def status_code
          409
        end
      end
    end
  end
end
