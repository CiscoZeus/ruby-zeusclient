require 'rest-client'

module RestInterface
  private
  def get(path, params={})
    RestClient.get "#{@endpoint}#{path}", {params: params}
  end

  def post(path, data={})
    RestClient.post "#{@endpoint}#{path}", data.to_json, :content_type => :json, :accept => :json
  end

  def put(path, data={})
    RestClient.put "#{@endpoint}#{path}", data.to_json, :content_type => :json, :accept => :json
  end

  def delete(path={})
    RestClient.delete "#{@endpoint}#{path}"
  end
end
