# frozen_string_literal: true

require_relative 'still_life/version'

module StillLife
  def self.record_html(html, location)
    if html.present?
      pathname, i = Rails.root.join("tmp/html/#{location.tr(':', '-')}.html"), 1
      while pathname.exist?
        i += 1
        pathname = Rails.root.join("tmp/html/#{location.tr(':', '-')}_#{i}.html")
      end
      pathname.parent.mkpath
      pathname.write html
    end
  end

  module ResponseBodyRecorder
    %W(get post put patch delete).each do |meth|
      define_method meth do |*args|
        super(*args).tap do
          location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)
          StillLife.record_html(response.body, location)
        end
      end
    end
  end
end

ActiveSupport.on_load :action_dispatch_integration_test do
  ActionDispatch::Integration::Session.prepend StillLife::ResponseBodyRecorder
end
