# frozen_string_literal: true

module StillLife
  module ActionDispatchExtension
    %W(get post put patch delete).each do |meth|
      define_method meth do |*args|
        super(*args).tap do
          StillLife.draw(response.body)
        end
      end
    end
  end
end
