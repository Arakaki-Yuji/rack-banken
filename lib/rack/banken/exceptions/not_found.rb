module Rack
  module Banken
    module Exceptions
      class NotFound < Base

        private

        def status_code
          404
        end
      end
    end
  end
end
