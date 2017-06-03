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
#

require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  # Interface for dealing with triggered alerts api calls
  module TrigalertsInterface
    include RestInterface

    # get triggered alerts
    # @return [Zeus::APIClient::Result]

    def triggered_alerts
      response = get("/triggeredalerts/#{@token}", @token, @bucket_name)
      @bucket_name = nil
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end

    # get triggered alerts in last 24 hours
    # @return [Zeus::APIClient::Result]

    def triggered_alerts_last_24_hours
      response = get("/triggeredalerts/#{@token}/last24", @token, @bucket_name)
      @bucket_name = nil
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end
  end
end
