require 'cgi'
class ApiKeyExtractor

  def initialize(data)
    @data = data
  end

  def api_key
    qs = @data["Query"]
    q = CGI::parse(qs)
    q["aid"][0]
  end

end
