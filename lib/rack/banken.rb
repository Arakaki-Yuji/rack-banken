require "rack/banken/version"

module Rack
  module Banken
    require "rack"
    require "json"

    require "rack/banken/exception_handler"
    require "rack/banken/exceptions/base"
    require "rack/banken/dsl"

    Dir[::File.expand_path('../banken/exceptions', __FILE__) << '/*.rb'].each do |file|
      require file
    end
  end
end
