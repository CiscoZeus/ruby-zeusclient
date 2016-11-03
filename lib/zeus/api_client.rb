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

require 'zeus/api_client/alerts_interface'
require 'zeus/api_client/metrics_interface'
require 'zeus/api_client/logs_interface'
require 'zeus/api_client/trigalerts_interface'

module Zeus

  # API Client for Zeus Service
  class APIClient
    include AlertsInterface, MetricsInterface,
            LogsInterface, TrigalertsInterface

    # constructor for Zeus::APIClient
    # @param       [Hash] opts the options to create z Zeus::APIClient instance
    # @option opts [String] :access_token The tokens for Zeus Service
    # @option opts [String] :endpoint The base url for API endpoint
    def initialize(opts={})
      @access_token = opts[:access_token]
      # makes sure its using https
      uri_parts = URI.split(opts[:endpoint])
      uri_parts[0] = "https://"
      @endpoint = uri_parts.join
    end
  end
end
