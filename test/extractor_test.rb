require 'test_helper'

class ApiKeyExtractorTestCase < TestCase
  def setup()
    @data = {"Query"=>"a=b&aid=123", "Path"=>"/"}

  end
  def test_extracts_api_key_from_data
    ex = ApiKeyExtractor.new(@data)
    assert_equal "123", ex.api_key
  end
end
