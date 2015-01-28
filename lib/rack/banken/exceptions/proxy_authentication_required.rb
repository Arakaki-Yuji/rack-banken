module Rack
  module Banken
    module Exceptions
      class ProxyAuthenticationRequired < Base

        private

        def status_code
          407
        end
      end
    end
  end
end
