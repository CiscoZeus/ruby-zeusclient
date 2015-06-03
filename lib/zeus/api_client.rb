require 'rest-client'
require 'zeus/api_client/version'

module Zeus

  class APIClient

    def initialize(options={})
      @access_token = options.access_token || ""
      @endpoint = options.endpoint || "http://api.ciscozeus.io"
    end

    def send_metrics(name, metrics)
      self.post("/metrics/#{@access_token}/#{name}/", {metrics: metrics})
    end

    def send_logs(name, logs)
      self.post("/logs/#{@access_token}/#{name}/", {logs: logs})
    end

    def get_metrics(name="", from_date="", to_date="", aggregator="", group_interval="", filter_condition="", limit="")
      params = {
          metric_name: name,
          from: from_date,
          to: to_date,
          aggregator_function: aggregator,
          group_interval: group_interval,
          filter_condition: filter_condition,
          limit: limit
      }
      self.get("/metrics/#{@access_token}/_values/", params)
    end

    def get_logs(name="", pattern="", from_date="", to_date="", offset="", limit="")
      params = {
          log_name: name,
          pattern: pattern,
          from: from_date,
          to: to_date,
          offset: offset,
          limit: limit
      }
      self.get("/logs/#{@access_token}/", params)
    end

    def get(path, params={})
      RestClient.get "#{@endpoint}#{path}", params
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

    private :get, :post, :put, :delete

  end
end
