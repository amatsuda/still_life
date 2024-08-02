# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rails'
require "still_life"

case ENV['TEST_FRAMEWORK']
when 'test-unit'
  require 'test/unit'
else
  require 'minitest'
  require 'minitest/autorun'
end

Test::Unit::TestCase.class_eval do
  def assert_html_dumped(path)
    assert File.exist?(f = "#{__dir__}/dummy_app/tmp/html/#{path}.html") && File.read(f).present?, "#{f} does not exist"
  end
end
