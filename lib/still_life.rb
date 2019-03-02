# frozen_string_literal: true

require_relative 'still_life/version'

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

  module PageBodyRecorder
    def self.prepended(kls)
      Capybara::Node::Element.prepend Module.new {
        def click(*)
          return super if Thread.current[:_still_life_inside_modal]

          body_was = session.body
          super.tap do
            session.find('body')
            if session.body.present? && (session.body != body_was)
              StillLife.draw(session.body)
            end
          end
        end
      }

      Capybara::Session.prepend Module.new {
        def visit(*)
          super.tap do
            if body.present?
              StillLife.draw(body)
            end
          end
        end

        private def accept_modal(*)
          Thread.current[:_still_life_inside_modal] = true
          body_was = body
          super.tap do
            if body.present? && (body != body_was)
              StillLife.draw(body)
            end
          end
        ensure
          Thread.current[:_still_life_inside_modal] = nil
        end

        private def dismiss_modal(*)
          Thread.current[:_still_life_inside_modal] = true
          body_was = body
          super.tap do
            if body.present? && (body != body_was)
              StillLife.draw(body)
            end
          end
        ensure
          Thread.current[:_still_life_inside_modal] = nil
        end
      }
    end
  end
end

ActiveSupport.on_load :action_dispatch_integration_test do
  ActionDispatch::Integration::Session.prepend StillLife::ResponseBodyRecorder
end
ActiveSupport.on_load :action_dispatch_system_test_case do
  ActionDispatch::SystemTestCase.prepend StillLife::PageBodyRecorder
end

begin
  require 'rspec-rails'

  #TODO maybe we could use some kind of hook instead of directly configuring here?
  RSpec.configure do |config|
    # config.prepend StillLife::ResponseBodyRecorder, type: :request
    config.prepend StillLife::ResponseBodyRecorder, type: :controller
    config.prepend StillLife::PageBodyRecorder, type: :feature
  end
rescue LoadError
end
