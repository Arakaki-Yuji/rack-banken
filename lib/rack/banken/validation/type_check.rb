require 'date'

module Rack
  module Banken
    module Validation
      module TypeCheck

        def integer?(value)
          Integer(value.to_s)
          true
        rescue ArgumentError, TypeError
          false
        end

        def number?(value)
          Float(value.to_s)
          true
        rescue ArgumentError, TypeError
          false
        end

        def string?(value)
          val = number?(value) ? value.to_s : value ;
          val.class == String
        end

        def file?(value)
          if value.is_a?(Hash) === false
            return false
          end

          must_has_keys = [:filename, :type, :name, :tempfile, :head]
          must_has_keys.each do |key|
            if value.keys.include?(key) == false
              return false
            end
          end
          true
        end

        def datetime?(value)
          DateTime.parse(value.to_s)
          true
        rescue  ArgumentError, TypeError
          false
        end
      end
    end
  end
end
