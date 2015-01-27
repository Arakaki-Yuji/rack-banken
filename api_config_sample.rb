# -*- coding: utf-8 -*-
# APIの設定ファイルのサンプル

Rack::Banken::DSL.request path: '/api/v1/self/weights', method: 'POST' do

  description "体重情報を登録する"

  property :id do
    description "unique identifiler of weight"
    example 1
    type :integer
    regexp /[1.]/
  end

  property :weight do
    description "weight number. unit is `kg`f"
    example 54.9
    type :number
    regexp /^\d{1,3}\.\d{1}$/
  end

end

Rack::Banken::DSL.response path: '/api/v1/self/weights', method: 'POST' do

  property :result do
    type :boolean
    example true
  end

end
