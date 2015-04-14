module Rack
  module Banken
    module Exceptions
      class PreconditionFailed < Base

        private

        def status_code
          412
        end
      end
    end
  end
end
