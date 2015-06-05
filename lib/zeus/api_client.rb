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

  # API Client for Zeus Service
  class APIClient

    # constructor for Zeus::APIClient
    # @param       [Hash] opts the options to create z Zeus::APIClient instance
    # @option opts [String] :access_token The tokens for Zeus Service
    # @option opts [String] :endpoint The base url for API endpoint
    def initialize(opts={})
      @access_token = opts[:access_token]
      @endpoint = opts[:endpoint] || "http://api.ciscozeus.io"
    end

    # Get metrics list
    # @param [String] regex a factor for filtering by metrics name
    #   [optional]
    #   [Examples] metric.name, metric.name*, metric.name.* etc.
    # @param [String] from_date a factor for filtering by start timestamp
    #   [optional]
    # @param [String] to_date a factor for filtering by end timestamp
    #   [optional]
    # @param [String] aggregator an aggregation methods
    #   [optional]
    # @param [String] group_interval grouping values by time interval
    #   [optional]
    #   [Examples] 1000s, 100m, 10h, 1d , 1w. Use 's' for seconds, 'm' for minutes, 'h' for hours, 'd' for days and 'w' for weeks.
    # @param [String] filter_condition a factor for filtering by metrics name
    #   [optional]
    # @param [String] limit a maximum number of returning values
    #   [optional]
    # @return [Zeus::APIClient::Result]
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
        response = get("/metrics/#{@access_token}/_names/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # Send metrics list
    # @param [String] name a name of metrics
    #   [Examples] metric.name, metric.name*, metric.name.* etc.
    # @param [Array] metrics a list of hash objects
    # @return [Zeus::APIClient::Result]
    def send_metrics(name, metrics)
      params = {metrics: metrics}
      begin
        response = post("/metrics/#{@access_token}/#{name}/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # Get metrics
    # @param [String] regex a factor for filtering by metrics name
    #   [optional]
    # @param [String] from_date a factor for filtering by start timestamp
    #   [optional]
    # @param [String] to_date a factor for filtering by end timestamp
    #   [optional]
    # @param [String] aggregator an aggregation methods
    #   [optional]
    # @param [String] group_interval grouping values by time interval
    #   [optional]
    #   [Examples] 1000s, 100m, 10h, 1d , 1w. Use 's' for seconds, 'm' for minutes, 'h' for hours, 'd' for days and 'w' for weeks.
    # @param [String] filter_condition filters to be applied to metric values
    #   [optional]
    #   [Examples] "column1 > 0", "column1 > 50 AND column2 = 10".
    # @param [Integer] limit a maximum number of returning values
    #   [optional]
    # @return [Zeus::APIClient::Result]
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
        response = get("/metrics/#{@access_token}/_values/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # delete metrics
    # @param [String] name a target metrics name
    # @return [Zeus::APIClient::Result]
    def delete_metrics(name)
      response = delete("/metrics/#{@access_token}/#{name}/")
      Result.new(response)
    end

    # send logs
    # @param [String] name a log name
    # @param [Array] logs a list of hash objects
    # @return [Zeus::APIClient::Result]
    def send_logs(name, logs)
      params = {logs:logs}
      begin
        response = post("/logs/#{@access_token}/#{name}/", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # get logs
    # @param [String] name a log name
    # @param [String] attribute_name Name of the attribute within the log to be searched.
    #   [optional]
    #   [Examples] if the submitted log has the format {"key1": "value1", "key2": "value2", "timestamp": 1430268064} then the value of this field can be "key1" or "key2"
    # @param [String] pattern a factor for fitering by name
    #   [optional]
    # @param [String] from_date a factor for filtering by start timestamp
    #   [optional]
    # @param [String] to_date a factor for filtering by end timestamp
    #   [optional]
    # @param [Integer] offset a factor for filtering by metrics name
    #   [optional]
    # @param [Integer] limit a maximum number of returning values
    #   [optional]
    # @return [Zeus::APIClient::Result]
    def get_logs(name, attribute_name=nil, pattern=nil, from_date=nil, to_date=nil, offset=nil, limit=nil)
      params = {log_name: name}  # required fields
      params.merge!(attribute_name: attribute_name) if attribute_name
      params.merge!(pattern: pattern) if pattern
      params.merge!(from: from_date)  if from_date
      params.merge!(to: to_date)      if to_date
      params.merge!(offset: offset)   if offset
      params.merge!(limit: limit)     if limit
      begin
        response = get("/logs/#{@access_token}", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

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
end
