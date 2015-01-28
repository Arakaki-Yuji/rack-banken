# -*- coding: utf-8 -*-
require 'spec_helper'
RSpec.describe "Rack::Banken" do
  include SpecHelper
  include Rack::Test::Methods

  let(:test_app) { SpecHelper::TestApplication.new }
  let(:app) { Rack::Banken::ExceptionHandler.new(test_app) }

  it "GET Access" do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq("test body")
  end


  ######################################################
  # 例外に合わせたレスポンスが返ってくるかのテストを生成する
  ######################################################

  exceptions = []
  Dir.glob('lib/rack/banken/exceptions/*.rb').each do |f|
    exceptions << File.basename(f).split('.').first
  end

  exceptions.each do |exception|

    class_s = "Rack::Banken::Exceptions::#{exception.camelize}"
    class_con = class_s.constantize
    status_code = class_con.new.to_rack_response.first

    eval <<-EOS

  describe_msg = "if " +  class_s + " occured"
  it_msg = "response body is formated by " + class_s
  it_staus_code_msg = "response status is " + status_code.to_s

  describe describe_msg  do
    let(:path) { '/' + exception }

    it it_staus_code_msg do
      get path
      expect(last_response.status).to eq(status_code)
    end

    it it_msg do
      get path
      json = JSON.parse(last_response.body)

      expect(json['result']).to eq(false)
      expect(json['error']).to be_kind_of(String)
    end
  end

    EOS

  end

end
