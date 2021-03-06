require "test_helper"

class StillLifeTest < Test::Unit::TestCase
  STILL_LIFE_ENV_VAR = 'test'

  def test_executing_tests_in_the_dummy_app
    Dir.chdir "#{__dir__}/dummy_app" do
      FileUtils.rm_rf 'tmp/html/'

      Bundler.with_unbundled_env do
        case ENV['TEST_FRAMEWORK']
        when 'test-unit'
          system "BUNDLE_GEMFILE=Gemfile.test-unit bundle u && BUNDLE_GEMFILE=Gemfile.test-unit STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails test"
        when 'rspec'
          system "BUNDLE_GEMFILE=Gemfile.rspec bundle u && BUNDLE_GEMFILE=Gemfile.rspec STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e rspec spec/controllers/ spec/requests/"
        else
          system "bundle u && STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails test"
        end

        case ENV['TEST_FRAMEWORK']
        when 'rspec'
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-105"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-112"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-130"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-136"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-79"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/controllers/users_controller_spec.rb-84"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/requests/users_spec.rb-6"
        else
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-9"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-14"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-20"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-27"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-32"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-37"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/controllers/users_controller_test.rb-43"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/integration/users_integration_test.rb-9"
        end

        case ENV['TEST_FRAMEWORK']
        when 'test-unit'
          system "BUNDLE_GEMFILE=Gemfile.test-unit bundle u && BUNDLE_GEMFILE=Gemfile.test-unit STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails test:system"
        when 'rspec'
          system "BUNDLE_GEMFILE=Gemfile.rspec bundle u && BUNDLE_GEMFILE=Gemfile.rspec STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails spec:system"
        else
          system "bundle u && STILL_LIFE=#{STILL_LIFE_ENV_VAR} bundle e bin/rails test:system"
        end

        case ENV['TEST_FRAMEWORK']
        when 'rspec'
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-11"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-16"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-17"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-20"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-23"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-27"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-28"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-31"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-34"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-38"
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/spec/system/users_spec.rb-39"
        else
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
          assert_html_dumped "#{STILL_LIFE_ENV_VAR}/test/system/users_test.rb-39"
        end
      end
    end
  end
end
