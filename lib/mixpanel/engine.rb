require 'mixpanel'

module Mixpanel
  class Engine < ::Rails::Railtie

    Config = Struct.new(:token, :options, :middleware)
    MiddlewareConfig = Struct.new(:use, :insert_js_last, :persist, :config)

    config.mixpanel = Config.new(nil, {}, MiddlewareConfig.new(false, false, false, {}))


    initializer 'mixpanel.setup' do |app|
      class << app
        attr_accessor :mixpanel
      end
      config.mixpanel.token ||= ENV['MIXPANEL_TOKEN']
      $stderr.puts <<-WARNING unless config.mixpanel.token
No Mixpanel token was configured for environment #{::Rails.env}! this application will be
unable to interact with mixpanel.com. You can set your token with either the environment
variable `MIXPANEL_TOKEN` (recommended) or by setting `config.mixpanel.token` in your
environment file directly.
WARNING
      app.mixpanel = Mixpanel::Tracker.new config.mixpanel.token, config.mixpanel.options
    end

    initializer 'mixpanel.middleware' do |app|
      mixpanel = config.mixpanel
      middleware = mixpanel.middleware
      if middleware.use
        config.middleware.use 'Mixpanel::Middleware', mixpanel.token, {
          :insert_js_last => middleware.insert_js_last,
          :persist => middleware.persist,
          :config => middleware.config
        }
      end
    end
  end
end