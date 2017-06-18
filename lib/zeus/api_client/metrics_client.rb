# coding: utf-8

# Copyright 2016 Cisco Systems, Inc.
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

require 'zeus/api_client/rest_client'
require 'zeus/api_client/result'

module Zeus
  # Interface for dealing with metrics api calls
  module MetricsClient
    include RestClient
    # Get metrics list
    # @param [Hash]  options can contain:
    #   @param [String] regex a factor for filtering by metrics name.
    #                   eg: metric.name, metric.name*, metric.name.* etc.
    #   @param [String] from_date a factor for filtering by start timestamp
    #   @param [String] to_date a factor for filtering by end timestamp
    #   @param [String] aggregator an aggregation methods
    #   @param [String] group_interval grouping values by time interval.
    #                   For example, 1000s, 100m, 10h, 1d , 1w
    #   @param [String] filter_condition a factor for filtering by metrics name
    #   @param [String] limit a maximum number of returning values
    # @return [Zeus::APIClient::Result]
    def list_metrics(options = {})
      response = get("/metrics/#{@token}/_names/",
                     make_header(@token, @bucket_name),
                     options)
      @bucket_name = nil
      Result.new(response)
    rescue RestClient::RequestFailed => e
      Result.new(e.response)
    end

    # Send metrics list
    # @param [String] name a name of metrics.
    #                 For example, metric.name, metric.name*, metric.name.* etc.
    # @param [Array] metrics a list of hash objects
    # @return [Zeus::APIClient::Result]
    def send_metrics(name, metrics)
      params = { metrics: metrics }
      begin
        response = post("/metrics/#{@token}/#{name}/",
                        make_header(@token, @bucket_name),
                        params)
        @bucket_name = nil
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # Get metrics
    # @param [Hash]  options can contain:
    #   @param [String] regex a factor for filtering by metrics name
    #   @param [String] from_date a factor for filtering by start timestamp
    #   @param [String] to_date a factor for filtering by end timestamp
    #   @param [String] aggregator an aggregation methods
    #   @param [String] group_interval grouping values by time interval.
    #                   For example, 1000s, 100m, 10h, 1d , 1w
    #   @param [String] filter_condition filters to be applied to metric values.
    #                   eg: "column1 > 0", "column1 > 50 AND column2 = 10"
    #   @param [Integer] limit a maximum number of returning values
    # @return [Zeus::APIClient::Result]
    def get_metrics(options = {})
      response = get("/metrics/#{@token}/_values/",
                     make_header(@token, @bucket_name),
                     options)
      @bucket_name = nil
      Result.new(response)
    rescue RestClient::RequestFailed => e
      Result.new(e.response)
    end

    # delete metrics
    # @param [String] name a target metrics name
    # @return [Zeus::APIClient::Result]
    def delete_metrics(name)
      response = delete("/metrics/#{@token}/#{name}/",
                        make_header(@token, @bucket_name))
      @bucket_name = nil
      Result.new(response)
    rescue RestClient::RequestFailed => e
      Result.new(e.response)
    end
  end
end
