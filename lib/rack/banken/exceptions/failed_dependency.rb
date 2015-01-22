module Rack
  module Banken
    module Exceptions
      class FailedDependency < Base

        private

        def status_code
          424
        end
      end
    end
  end
end
