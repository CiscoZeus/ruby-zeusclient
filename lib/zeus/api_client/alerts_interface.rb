require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  module AlertsInterface
    include RestInterface

    # create alert
    # @param [String]  alert_name name of the alert
    # @param [String]  username account username
    # @param [String]  token account token
    # @param [String]  alerts_type alert type, metrics or logs
    # @param [String]  alert_expression expression to evaluate the alert
    # @param [String]  alert_severity severity level of the alert
    # @param [String]  metric_name <TODO add description>
    # @param [String]  emails recipients to receive notifications
    # @param [String]  status if the alerts is enabled or not
    # @param [Integer] frequency <TODO add description>
    # @return [Zeus::APIClient::Result]

    def create_alert(
          alert_name, username, token, alerts_type, alert_expression,
          alert_severity, metric_name, emails, status, frequency
        )
      params = {
        alert_name: alert_name,
        username: username,
        token: token,
        alerts_type: alerts_type,
        alert_expression: alert_expression,
        alert_severity: alert_severity,
        metric_name: metric_name,
        emails: emails,
        status: status,
        frequency: frequency
      }

      begin
        response = post("/alerts/#{@access_token}", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # modify alert
    # @param [Integer] alert_id id of the alert to be modified
    # @param [String]  alert_name name of the alert
    # @param [String]  username account username
    # @param [String]  token account token
    # @param [String]  alerts_type alert type, metrics or logs
    # @param [String]  alert_expression expression to evaluate the alert
    # @param [String]  alert_severity severity level of the alert
    # @param [String]  metric_name <TODO add description>
    # @param [String]  emails recipients to receive notifications
    # @param [String]  status if the alerts is enabled or not
    # @param [Integer] frequency <TODO add description>
    # @return [Zeus::APIClient::Result]

    def modify_alert(
          alert_id, alert_name, username, token, alerts_type, alert_expression,
          alert_severity, metric_name, emails, status, frequency
        )
      params = {
        alert_name: alert_name,
        username: username,
        token: token,
        alerts_type: alerts_type,
        alert_expression: alert_expression,
        alert_severity: alert_severity,
        metric_name: metric_name,
        emails: emails,
        status: status,
        frequency: frequency
      }

      begin
        response = put("/alerts/#{@access_token}/#{alert_id}", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # get alerts
    # @param [String] metric Name of metric that alerts are associated with
    # @return [Zeus::APIClient::Result]

    def get_alerts(metric=nil)
      params = {metric: metric}
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
      begin
        response = get("/alerts/#{@access_token}/#{alert_id}")
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # delete alert
    # @param [Integer] alert_id id of alert to be deleted
    # @return [Zeus::APIClient::Result]

    def delete_alert(alert_id)
      begin
        response = delete("/alerts/#{@access_token}/#{alert_id}")
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # enable alerts
    # @param [Array[Integer]] alert_id_list list of alert ids to be enabled
    # @return [Zeus::APIClient::Result]

    def enable_alerts(alert_id_array)
      params = {id: alert_id_array}
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
      params = {id: alert_id_array}
      begin
        response = post("/alerts/#{@access_token}/disable", params)
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end
  end
end
