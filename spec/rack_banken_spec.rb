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

  describe "if Exception occured" do
    let(:path){ '/runtime_error' }

    it "response staus is 500" do
      get path
      expect(last_response.status).to eq(500)
    end

    it "response body is formated by Rack::Banken::Exceptions::Base.body" do
      get path
      json = JSON.parse(last_response.body)

      expect(json['result']).to eq(false)
      expect(json['error']).to be_kind_of(String)
    end
  end

  describe "if Exception Rack::Banken::Exceptions::ValidationFailed occured" do
    let(:path) { '/validation_failed' }

    it "response status is 400" do
      get path
      expect(last_response.status).to eq(400)
    end

    it "response body is formated by Rack::Banken::Exceptions::ValidationFailed" do
      get path
      json = JSON.parse(last_response.body)

      expect(json['result']).to eq(false)
      expect(json['error']).to be_kind_of(String)
    end

  end

end
