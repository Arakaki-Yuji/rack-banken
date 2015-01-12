# Rack::Banken

Banken is Rack application for return error response by unified way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-banken', github: "Arakaki-Yuji/rack-banken"
```

And then execute:

    $ bundle install

## How to Setup

If you use it no rails

````ruby:config/application.rb

.
.
.
module MyApp
  class Application < Rails::Application

    config.middleware.insert(0, ::Rack::Banken::ExceptionHandler)
  end
end

````
