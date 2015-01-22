module Rack
  module Banken
    module Exceptions
      class Locked < Base

        private

        def status_code
          423
        end
      end
    end
  end
end
