# coding: utf-8
require 'spec_helper'

RSpec.describe "Rack::Banken::RequestValidator" do
  include SpecHelper
  include Rack::Test::Methods
  before(:all) do
    load 'spec/api_config_sample.rb'
  end

  let(:test_app) { SpecHelper::TestApplication.new }
  let(:validator_app) { Rack::Banken::RequestValidator.new(test_app, Rack::Banken::DSL) }
  let(:app){ Rack::Banken::ExceptionHandler.new(validator_app) }


  it "GET Access" do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq("test body")
  end

  describe "Rack::Banken::DSLに登録されたPATHとMETHODのアクセスがくると" do
    let(:path) { '/api/v1/self/weights' }

    context "パラメータのチェックを行ない、" do

      describe "必須項目がないと" do

        let(:invalid_params) do
          {weight: 54.6}
        end

        it "400のステータスコードがかえってくる" do
          post path, invalid_params
          expect(last_response.status).to eq(400)
        end

      end

      describe "正しいパラメータを送信していれば" do
        let(:valid_params) do
          {id: 1, weight: 54.6}
        end

        it "エラーレスポンスではかえって来ない" do
          post path, valid_params
          expect(last_response.status).to eq(200)
          expect(last_response.body).to eq("test body")
        end
      end

    end
  end

end
