module Rack
  module Banken
    module Exceptions
      class NotAcceptable < Base

        private

        def status_code
          406
        end
      end
    end
  end
end
