module Rack
  module Banken
    module Exceptions
      class LengthRequired < Base

        private

        def status_code
          411
        end
      end
    end
  end
end
