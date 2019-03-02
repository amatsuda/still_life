# frozen_string_literal: true

module StillLife
  module CapybaraExtension
    module ElementExtension
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
    end

    module SessionExtension
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
    end

    def self.included(*)
      Capybara::Node::Element.prepend ElementExtension
      Capybara::Session.prepend SessionExtension
    end
  end
end
