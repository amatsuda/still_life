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
