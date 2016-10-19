require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  module TrigalertsInterface
    include RestInterface

    # get triggered alerts
    # @return [Zeus::APIClient::Result]

    def get_triggered_alerts()
      begin
        response = get("/trigalerts/#{@access_token}")
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end

    # get triggered alerts in last 24 hours
    # @return [Zeus::APIClient::Result]

    def get_triggered_alerts_last_24_hours()
      begin
        response = get("/trigalerts/#{@access_token}/last24")
        Result.new(response)
      rescue => e
        Result.new(e.response)
      end
    end
  end
end
