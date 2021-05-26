# frozen_string_literal: true

module StillLife
  module ActionDispatchExtension
    def get(*, **)
      super.tap do
        StillLife.draw(response.body) unless response.get_header('Content-Transfer-Encoding') == 'binary'
      end
    end

    def post(*, **)
      super.tap do
        StillLife.draw(response.body) unless response.get_header('Content-Transfer-Encoding') == 'binary'
      end
    end

    def put(*, **)
      super.tap do
        StillLife.draw(response.body) unless response.get_header('Content-Transfer-Encoding') == 'binary'
      end
    end

    def patch(*, **)
      super.tap do
        StillLife.draw(response.body) unless response.get_header('Content-Transfer-Encoding') == 'binary'
      end
    end

    def delete(*, **)
      super.tap do
        StillLife.draw(response.body) unless response.get_header('Content-Transfer-Encoding') == 'binary'
      end
    end
  end
end
