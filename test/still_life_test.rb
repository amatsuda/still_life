require "test_helper"

class StillLifeTest < Test::Unit::TestCase
  def test_executing_tests_in_the_dummy_app
    Dir.chdir "#{__dir__}/dummy_app" do
      Bundler.with_clean_env do
        system 'bundle e rails test'
        system 'bundle e rails test:system'
      end
    end
  end
end
