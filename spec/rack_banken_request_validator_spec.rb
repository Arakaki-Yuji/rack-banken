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

    describe "ファイルアップロードのバリデーションチェックをする" do
      let(:image_path) { '/api/v1/image' }

      it "type :fileを指定しているパラメータでFileをアップロードするとバリデーションにかからない" do
        params = {image: Rack::Test::UploadedFile.new('spec/fixture/ruby.jpeg', 'image/jpeg') }
        post image_path, params
        expect(last_response.status).to eq(200)
      end

      describe "type :fileを指定しているパラメータに他の値を入れると" do

        it "エラーレスポンスが返ってくる" do
          invalid_params = {image: "Image File"}
          post image_path, invalid_params
          expect(last_response.status).to eq(400)
        end

      end
    end

    describe ":datetime typeのパラメータをチェックする" do
      let(:path) { '/api/v1/image' }
      let(:valid_params) do
        {image: Rack::Test::UploadedFile.new('spec/fixture/ruby.jpeg', 'image/jpeg'),
         created: '2014-12-30'}
      end
      let(:invalid_params) do
        {image: Rack::Test::UploadedFile.new('spec/fixture/ruby.jpeg', 'image/jpeg'),
         created: 'あいうえお'}
      end

      it "type :datetimeを指定しているパラメータで日付を表す文字列であればバリデーションにかからない " do
        post path, valid_params
        expect(last_response.status).to eq(200)
      end

      it "日付と判断できない文字列を与えるとエラーメッセージが返ってくる" do
        post path, invalid_params
        expect(last_response.status).to eq(400)
      end
    end
  end

end
