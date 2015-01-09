module Rack
  module Banken
    module Exceptions
      class ValidationFailed < Base
        def status_code
          400
        end
      end
    end
  end
end
