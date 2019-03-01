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

  module PageBodyRecorder
    def self.prepended(kls)
      Capybara::Node::Element.prepend Module.new {
        def click(*)
          return super if Thread.current[:_still_life_inside_modal]

          body_was = session.body
          super.tap do
            if session.body.present? && (session.body != body_was)
              location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)
              StillLife.record_html(session.body, location)
            end
          end
        end
      }

      Capybara::Session.prepend Module.new {
        def visit(*)
          super.tap do
            if body.present?
              location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)
              StillLife.record_html(body, location)
            end
          end
        end

        private def accept_modal(*)
          Thread.current[:_still_life_inside_modal] = true
          body_was = body
          super.tap do
            if body.present? && (body != body_was)
              location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)
              StillLife.record_html(body, location)
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
              location = caller.detect {|c| c =~ /^#{Rails.root}/}.remove(Rails.root.to_s, /:in .*$/)
              StillLife.record_html(body, location)
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
