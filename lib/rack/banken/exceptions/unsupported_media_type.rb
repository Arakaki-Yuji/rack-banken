module Rack
  module Banken
    module Exceptions
      class UnsupportedMediaType < Base

        private

        def status_code
          415
        end
      end
    end
  end
end
