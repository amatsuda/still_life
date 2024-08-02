require "test_helper"

class StillLifeTest < defined?(Test::Unit) ? Test::Unit::TestCase : Minitest::Test
  STILL_LIFE_ENV_VAR = 'test'

  def test_executing_tests_in_the_dummy_app
    Dir.chdir "#{__dir__}/dummy_app" do
      FileUtils.rm_rf 'tmp/html/'

      system "RAILS_VERSION=#{ENV['RAILS_VERSION']} bundle u"
      system "RAILS_VERSION=#{ENV['RAILS_VERSION']} bundle e rails db:setup"

      system "RAILS_VERSION=#{ENV['RAILS_VERSION']} STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e rake test"

      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-9"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-14"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-20"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-27"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-32"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-37"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-43"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/integration/users_integration_test.rb-9"

      system "RAILS_VERSION=#{ENV['RAILS_VERSION']} STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails test:system"

      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-9"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-14"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-15"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-19"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-23"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-27"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-28"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-31"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-34"
      assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-38"
      # assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-39"
    end
  end

  private def assert_html_dumped(path)
    assert File.exist?(f = "#{__dir__}/dummy_app/tmp/html/#{path}.html") && File.read(f).present?, "#{f} does not exist"
  end
end
