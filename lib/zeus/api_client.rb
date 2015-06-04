# Copyright 2015 Cisco Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rest-client'
require 'zeus/api_client/result'
require 'zeus/api_client/version'

module Zeus

  class APIClient

    def initialize(access_token, endpoint=nil)
      @access_token = access_token
      @endpoint = endpoint || "http://api.ciscozeus.io"
    end

    def list_metrics(regex=nil, from_date=nil, to_date=nil, aggregator=nil, group_interval=nil, filter_condition=nil, limit=nil)
      params = {
          metric_name: regex||"",
          from: from_date||"",
          to: to_date||"",
          aggregator_function: aggregator||"",
          group_interval: group_interval||"",
          filter_condition: filter_condition||"",
          limit: limit||50
      }
      response = self.get("/metrics/#{@access_token}/_names/", params)
      Result.new(response)
    end

    # test needed
    def send_metrics(name, metrics)
      self.post("/metrics/#{@access_token}/#{name}/", {metrics: metrics})
    end

    def get_metrics(regex=nil, from_date=nil, to_date=nil, aggregator=nil, group_interval=nil, filter_condition=nil, limit=nil)
      params = {
          metric_name: regex||"",
          from: from_date||"",
          to: to_date||"",
          aggregator_function: aggregator||"",
          group_interval: group_interval||"",
          filter_condition: filter_condition||"",
          limit: limit||50
      }
      response = self.get("/metrics/#{@access_token}/_values/", params)
      Result.new(response)
    end

    def delete_metrics(name)
      response = self.delete("/metrics/#{@access_token}/#{name}/")
      Result.new(response)
    end

    def send_logs(name, logs)
      response = self.post("/logs/#{@access_token}/#{name}/", {logs:logs})
      Result.new(response)
    end

    def get_logs(name, pattern=nil, from_date=nil, to_date=nil, offset=nil, limit=nil)
      params = {
          log_name: name,
          pattern: pattern||"*",
          from: from_date||0,
          to: to_date||100_000_000_000, # this might need to modify server side implementation
          offset: offset||0,
          limit: limit||50
      }
      response = self.get("/logs/#{@access_token}", params)
      Result.new(response)
    end

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
end
