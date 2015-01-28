module Rack
  module Banken
    module Exceptions
      class UpgradeRequired < Base

        private

        def status_code
          426
        end
      end
    end
  end
end
