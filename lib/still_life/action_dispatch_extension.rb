# frozen_string_literal: true

module StillLife
  module ActionDispatchExtension
    def get(*args)
      super(*args).tap do
        StillLife.draw(response.body)
      end
    end

    def post(*args)
      super(*args).tap do
        StillLife.draw(response.body)
      end
    end

    def put(*args)
      super(*args).tap do
        StillLife.draw(response.body)
      end
    end

    def patch(*args)
      super(*args).tap do
        StillLife.draw(response.body)
      end
    end

    def delete(*args)
      super(*args).tap do
        StillLife.draw(response.body)
      end
    end
  end
end
