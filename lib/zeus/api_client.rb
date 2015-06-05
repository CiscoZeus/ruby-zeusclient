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

    def initialize(opts={})
      @access_token = opts[:access_token]
      @endpoint = opts[:endpoint] || "http://api.ciscozeus.io"
    end

    def list_metrics(regex=nil, from_date=nil, to_date=nil, aggregator=nil, group_interval=nil, filter_condition=nil, limit=nil)
      params = {}
      params.merge!(metric_name: regex)                 if regex
      params.merge!(from: from_date)                    if from_date
      params.merge!(to: to_date)                        if to_date
      params.merge!(aggregator_function: aggregator)    if aggregator
      params.merge!(group_interval: group_interval)     if group_interval
      params.merge!(filter_condition: filter_condition) if filter_condition
      params.merge!(limit: limit)                       if limit
      begin
        response = self.get("/metrics/#{@access_token}/_names/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    def send_metrics(name, metrics)
      params = {metrics: metrics}
      begin
        response = self.post("/metrics/#{@access_token}/#{name}/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    def get_metrics(regex=nil, from_date=nil, to_date=nil, aggregator=nil, group_interval=nil, filter_condition=nil, limit=nil)
      params = {}
      params.merge!(metric_name: regex)                 if regex
      params.merge!(from: from_date)                    if from_date
      params.merge!(to: to_date)                        if to_date
      params.merge!(aggregator_function: aggregator)    if aggregator
      params.merge!(group_interval: group_interval)     if group_interval
      params.merge!(filter_condition: filter_condition) if filter_condition
      params.merge!(limit: limit)                       if limit
      begin
        response = self.get("/metrics/#{@access_token}/_values/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    def delete_metrics(name)
      response = self.delete("/metrics/#{@access_token}/#{name}/")
      Result.new(response)
    end

    def send_logs(name, logs)
      params = {logs:logs}
      begin
        response = self.post("/logs/#{@access_token}/#{name}/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    def get_logs(name, pattern=nil, from_date=nil, to_date=nil, offset=nil, limit=nil)
      params = {log_name: name}  # required fields
      params.merge!(pattern: pattern) if pattern
      params.merge!(from: from_date)  if from_date
      params.merge!(to: to_date)      if to_date
      params.merge!(offset: offset)   if offset
      params.merge!(limit: limit)     if limit
      begin
        response = self.get("/logs/#{@access_token}", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    def get(path, params={})
      RestClient.get "#{@endpoint}#{path}", {params: params}
    end

    def post(path, data={})
      p "#{@endpoint}#{path}"
      p data
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
