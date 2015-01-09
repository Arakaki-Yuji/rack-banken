$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))
 
%w(rubygems rack rack/test rack/banken rspec).each do |f|
  require f
end

module SpecHelper
  extend self

  class TestApplication
    def call(env)
      request = Rack::Request.new(env)

      if request.path_info == '/runtime_error'
        raise StandardError, 'runtime error is occured'
      end

      if request.path_info == '/validation_failed'
        raise ::Rack::Banken::Exceptions::ValidationFailed, 'params is not valid.'
      end

      code = 200
      body = ["test body"]
      header = {
        "Content-type" => "text/html;charset=utf-8"
      }
      [code, header, body]
    end
  end

end
