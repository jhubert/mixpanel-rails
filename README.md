# Mixpanel::Rails

Painlessly integrate your rails application with [Mixpanel][1]

## Installation

Add this line to your application's Gemfile:

    gem 'mixpanel-rails'

## Configuration

Set the `config.mixpanel.api_token` parameter in your applications configuration or
the `MIXPANEL_API_TOKEN` environment variable. e.g.

    # config/environments/staging.rb
    config.mixpanel.token = 'XYZ'
    config.mixpanel.options = {:async => true}

Want to use the [middleware for tracking with JavaScript][2]?

    # config/application.rb
    config.mixpanel.middleware.use = true
    config.mixpanel.middleware.persist = false
    config.mixpanel.middlware.insert_js_last = true
    config.mixpanel.middleware.config = {:cookie_name => 'mixpanel_cookie' }

## Usage

You can now access a pre-configured instance of `Mixpanel::Tracker` from anywhere in
your application by including the `Mixpanel::Helper` module:

    class User < ActiveRecord::Base
      include Mixpanel::Helper
      after_create :notify_mixpanel

      def notify_mixpanel
        mixpanel.track 'User Created', :distinct_id => self.id
      end
    end

Alternatively, you can use `Rails.application.mixpanel` if you don't want to include the module

[1]: http://mixpanel.com
[2]: https://github.com/zevarito/mixpanel#rack-middleware