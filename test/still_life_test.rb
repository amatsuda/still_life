require "test_helper"

class StillLifeTest < Test::Unit::TestCase
  def test_executing_tests_in_the_dummy_app
    Dir.chdir "#{__dir__}/dummy_app" do
      FileUtils.rm_rf 'tmp/html/'

      Bundler.with_clean_env do
        system 'bundle e rails test'

        assert_html_dumped 'test/controllers/users_controller_test.rb-9'
        assert_html_dumped 'test/controllers/users_controller_test.rb-14'
        assert_html_dumped 'test/controllers/users_controller_test.rb-20'
        assert_html_dumped 'test/controllers/users_controller_test.rb-27'
        assert_html_dumped 'test/controllers/users_controller_test.rb-32'
        assert_html_dumped 'test/controllers/users_controller_test.rb-37'
        assert_html_dumped 'test/controllers/users_controller_test.rb-43'
        assert_html_dumped 'test/integration/users_integration_test.rb-9'

        system 'bundle e rails test:system'

        assert_html_dumped 'test/system/users_test.rb-9'
        assert_html_dumped 'test/system/users_test.rb-14'
        assert_html_dumped 'test/system/users_test.rb-15'
        assert_html_dumped 'test/system/users_test.rb-18'
        assert_html_dumped 'test/system/users_test.rb-21'
        assert_html_dumped 'test/system/users_test.rb-25'
        assert_html_dumped 'test/system/users_test.rb-26'
        assert_html_dumped 'test/system/users_test.rb-29'
        assert_html_dumped 'test/system/users_test.rb-32'
        assert_html_dumped 'test/system/users_test.rb-36'
        assert_html_dumped 'test/system/users_test.rb-37'
      end
    end
  end
end
