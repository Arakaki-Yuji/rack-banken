# -*- coding: utf-8 -*-
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

%w(rubygems
   rack
   rack/test
   rack/banken
   rspec
   active_support/core_ext/string/inflections
   active_support/inflector).each do |f|

  require f
end

module SpecHelper
  extend self

  class TestApplication
    def call(env)
      request = Rack::Request.new(env)

      exceptions = []
      Dir.glob('lib/rack/banken/exceptions/*.rb').each do
        |f| exceptions << File.basename(f).split('.').first
      end

      #################################################
      # 例外名のパス(例: /bad_request)のリクエストを受けたら
      # その名前の例外を発生されるように定義する。
      #################################################
      exceptions.each do |ex|
        if request.path_info == "/#{ex}"
          klass = "Rack::Banken::Exceptions::#{ex.camelize}"
          raise klass.constantize
        end
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
