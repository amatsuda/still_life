# frozen_string_literal: true

require_relative 'still_life/version'
require_relative 'still_life/capybara_extension'
require_relative 'still_life/railtie'

module StillLife
  def self.draw(html)
    location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)

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
          StillLife.draw(response.body)
        end
      end
    end
  end
end
