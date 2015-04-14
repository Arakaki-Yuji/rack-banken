module Rack
  module Banken
    module Exceptions
      class Gone < Base

        private

        def status_code
          410
        end
      end
    end
  end
end
