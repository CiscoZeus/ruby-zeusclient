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

require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  # Interface for dealing with logs api calls
  module LogsInterface
    include RestInterface
    # send logs
    # @param [String] name a log name
    # @param [Array] logs a list of hash objects
    # @return [Zeus::APIClient::Result]
    def send_logs(name, logs)
      params = { logs: logs }
      begin
        response = post("/logs/#{@token}/#{name}/", @token, @bucket_name, params)
        @bucket_name = nil
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # get logs
    # @param [String] name a log name
    # @param [Hash]  options can contain:
    #   @param [String] attribute_name Name of the attribute within
    #                                     the log to be searched.
    #   @param [String] pattern a factor for filtering by name
    #   @param [String] from_date a factor for filtering by start timestamp
    #   @param [String] to_date a factor for filtering by end timestamp
    #   @param [Integer] offset a factor for filtering by metrics name
    #   @param [Integer] limit a maximum number of returning values
    # @return [Zeus::APIClient::Result]
    def get_logs(name, options = {})
      options[:log_name] = name
      response = get("/logs/#{@token}", @token, @bucket_name, options)
      @bucket_name = nil
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end
  end
end
