module Mixpanel
  module Helper
    def mixpanel
      config = ::Rails.application.config
      Mixpanel::Tracker.new(config.mixpanel.token, config.mixpanel.options.merge(mixpanel_options)).tap do |tracker|
        tracker.extend TrackerProperties
        tracker.mixpanel_properties = mixpanel_properties
      end
    end

    def mixpanel_properties
      {}
    end

    def mixpanel_options
      {}
    end

    module TrackerProperties
      attr_accessor :mixpanel_properties

      def track(event_name, properties = {}, options = {})
        super event_name, mixpanel_properties.merge(properties), options
      end
    end
  end
end