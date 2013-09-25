require 'mixpanel-ruby'

module Mixpanel
  class Engine < ::Rails::Railtie

    Config = Struct.new(:token, :options)

    config.mixpanel = Config.new(nil, {})

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
      app.mixpanel = Mixpanel::Tracker.new config.mixpanel.token
    end
  end
end
