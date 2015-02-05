# coding: utf-8
require 'spec_helper'

RSpec.describe "Rack::Banken::Validation::TypeCheck" do
  let(:typecheck) do
    typecheck = Object.new
    typecheck.extend(Rack::Banken::Validation::TypeCheck)
    typecheck
  end

  describe "integer?()" do
    it "整数を入れたらtrueを返す" do
      expect(typecheck.integer?(123)).to be true
    end

    it "整数の文字列を入れるとtrueを返す" do
      expect(typecheck.integer?('123')).to be true
    end

    it "整数じゃない文字列を入れるとfalseを返す" do
      expect(typecheck.integer?("あいうえお")).to be false
    end

    it "小数を入れるとfalseを返す" do
      expect(typecheck.integer?(123.98)).to be false
    end

    it "小数の文字列を入れるとfalseを返す" do
      expect(typecheck.integer?("123.45")).to be false
    end

    it "nilはfalseを返す" do
      expect(typecheck.integer?(nil)).to be false
    end

  end

  describe "number?()" do
    it "整数を入れたらtrueを返す" do
      expect(typecheck.number?(123)).to be true
    end

    it "整数の文字列を入れるとtrueを返す" do
      expect(typecheck.number?('123')).to be true
    end

    it "小数を入れるとtrueを返す" do
      expect(typecheck.number?(123.98)).to be true
    end

    it "小数の文字列を入れるとtrueを返す" do
      expect(typecheck.number?("123.45")).to be true
    end


    it "整数じゃない文字列を入れるとfalseを返す" do
      expect(typecheck.number?("あいうえお")).to be false
    end

    it "nilはfalseを返す" do
      expect(typecheck.number?(nil)).to be false
    end
  end

  describe "string()" do
    it "文字列を与えるとtrueを返す" do
      expect(typecheck.string?("あいうえあ")).to be true
    end

    it "数値を与えるとtrueを返す" do
      expect(typecheck.string?(123)).to be true
    end

    it "文字列、数値以外のオブジェクトを与えるとfalseを返す" do
      file = File.open("spec/api_config_sample.rb")
      file.close
      expect(typecheck.string?(file)).to be false
    end
  end



end
