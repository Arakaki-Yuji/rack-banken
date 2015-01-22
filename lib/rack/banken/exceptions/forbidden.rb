module Rack
  module Banken
    module Exceptions
      class Forbidden < Base

        private

        def status_code
          403
        end
      end
    end
  end
end
