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
  # Interface for dealing with alerts api calls
  module AlertsInterface
    include RestInterface

    # create alert
    # @param [Hash]  alert_data must contain:
    #   @param [String]  alert_name name of the alert
    #   @param [String]  username account username
    #   @param [String]  token account token
    #   @param [String]  alerts_type alert type, metrics or logs
    #   @param [String]  alert_expression expression to evaluate the alert
    #   @param [String]  alert_severity severity level of the alert
    #   @param [String]  metric_name <TODO add description>
    #   @param [String]  emails recipients to receive notifications
    #   @param [String]  status if the alerts is enabled or not
    #   @param [Integer] frequency <TODO add description>
    # @return [Zeus::APIClient::Result]

    def create_alert(alert_data)
      alert_data[:token] = @access_token
      response = post("/alerts/#{@access_token}", alert_data)
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end

    # modify alert
    # @param [Integer] alert_id id of the alert to be modified
    # @param [Hash]  alert_data must contain:
    #   @param [String]  alert_name name of the alert
    #   @param [String]  username account username
    #   @param [String]  token account token
    #   @param [String]  alert_expression expression to evaluate the alert
    #   Optional params:
    #   @param [String]  alerts_type alert type, metrics or logs
    #   @param [String]  alert_severity severity level of the alert
    #   @param [String]  metric_name <TODO add description>
    #   @param [String]  emails recipients to receive notifications
    #   @param [String]  status if the alerts is enabled or not
    #   @param [Integer] frequency <TODO add description>
    # @return [Zeus::APIClient::Result]

    def modify_alert(alert_id, alert_data)
      alert_data[:token] = @access_token
      response = put("/alerts/#{@access_token}/#{alert_id}", alert_data)
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end

    # get alerts
    # @param [String] metric Name of metric that alerts are associated with
    # @return [Zeus::APIClient::Result]

    def get_alerts(metric = nil)
      params = { metric: metric }
      begin
        response = get("/alerts/#{@access_token}", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # get alert
    # @param [Integer] alert_id id of alert to be retrieved
    # @return [Zeus::APIClient::Result]

    def get_alert(alert_id)
      response = get("/alerts/#{@access_token}/#{alert_id}")
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end

    # delete alert
    # @param [Integer] alert_id id of alert to be deleted
    # @return [Zeus::APIClient::Result]

    def delete_alert(alert_id)
      response = delete("/alerts/#{@access_token}/#{alert_id}")
      Result.new(response)
    rescue => e
      Result.new(e.response)
    end

    # enable alerts
    # @param [Array[Integer]] alert_id_list list of alert ids to be enabled
    # @return [Zeus::APIClient::Result]

    def enable_alerts(alert_id_array)
      params = { id: alert_id_array }
      begin
        response = post("/alerts/#{@access_token}/enable", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # disable alerts
    # @param [Array[Integer]] alert_id_list list of alert ids to be disabled
    # @return [Zeus::APIClient::Result]

    def disable_alerts(alert_id_array)
      params = { id: alert_id_array }
      begin
        response = post("/alerts/#{@access_token}/disable", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end
  end
end
