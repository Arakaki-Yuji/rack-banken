# -*- coding: utf-8 -*-
require 'spec_helper'
RSpec.describe "Rack::Banken::DSL" do
  before(:all) do
    load 'spec/api_config_sample.rb'
  end

  describe "Rack::Banken::DSLの定義ファイルapi_config_sample.rbをロードすると" do

    it "requestsが一つ定義されている" do
      expect(Rack::Banken::DSL.requests.count).to eq(1)
    end

    describe "requestオブジェクトには" do
      let(:request) { Rack::Banken::DSL.requests.first }

      it "descriptionに`体重情報を登録する`と登録されている" do
        expect(request.get_description).to eq('体重情報を登録する')
      end

      it "propertyが2つ登録されている" do
        expect(request.properties.count).to eq(2)
      end

      it "一つめのpropertyにはpropertyブロック内に記載した内容が登録されている" do
        property = request.properties.first

        expect(property.name).to eq(:id)
        expect(property.get_description).to eq("unique identifiler of weight")
        expect(property.get_example).to eq(1)
        expect(property.get_type).to eq(:integer)
        expect(property.get_regexp).to eq(/[1.]/)
      end

    end

    it "responseが一つ定義されている" do
      expect(Rack::Banken::DSL.responses.count).to eq(1)
    end

    describe "responseオブジェクトには" do
      let(:res) { Rack::Banken::DSL.responses.first }

      it "ひとつのpropertyが入っている" do
        expect(res.properties.count).to eq(1)
      end

      it "propertにはpropertyブロック内に記載した内容が登録されている" do
        property = res.properties.first
        expect(property.name).to eq(:result)
        expect(property.get_type).to eq(:boolean)
        expect(property.get_example).to eq(true)
      end
    end
  end

end
