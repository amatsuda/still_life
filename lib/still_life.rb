# frozen_string_literal: true

require_relative 'still_life/version'

module StillLife
  def self.record_html(html, location)
    if html.present?
      pathname = Rails.root.join("tmp/html/#{location.tr(':', '-')}.html")
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
