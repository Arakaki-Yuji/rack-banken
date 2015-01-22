module Rack
  module Banken
    module Exceptions
      class MethodNotAllowed < Base

        private

        def status_code
          405
        end
      end
    end
  end
end
