# frozen_string_literal: true

module StillLife
  module ActionDispatchExtension
    def get(*, **)
      super.tap do
        StillLife.draw(response.body)
      end
    end

    def post(*, **)
      super.tap do
        StillLife.draw(response.body)
      end
    end

    def put(*, **)
      super.tap do
        StillLife.draw(response.body)
      end
    end

    def patch(*, **)
      super.tap do
        StillLife.draw(response.body)
      end
    end

    def delete(*, **)
      super.tap do
        StillLife.draw(response.body)
      end
    end
  end
end
