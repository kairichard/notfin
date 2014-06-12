$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))

require 'minitest/autorun'
require 'rspec/mocks'
require 'pry' if ENV['DEBUG']

require 'extractor'

require_relative 'support/mini_test'

class TestCase < MiniTest::Test
end
