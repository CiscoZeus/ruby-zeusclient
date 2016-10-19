require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  module MetricsInterface
    include RestInterface
    # Get metrics list
    # @param [String] regex a factor for filtering by metrics name. For example, metric.name, metric.name*, metric.name.* etc.
    # @param [String] from_date a factor for filtering by start timestamp
    # @param [String] to_date a factor for filtering by end timestamp
    # @param [String] aggregator an aggregation methods
    # @param [String] group_interval grouping values by time interval. For example, 1000s, 100m, 10h, 1d , 1w
    # @param [String] filter_condition a factor for filtering by metrics name
    # @param [String] limit a maximum number of returning values
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
    # @param [String] name a name of metrics. For example, metric.name, metric.name*, metric.name.* etc.
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
    # @param [String] from_date a factor for filtering by start timestamp
    # @param [String] to_date a factor for filtering by end timestamp
    # @param [String] aggregator an aggregation methods
    # @param [String] group_interval grouping values by time interval. For example, 1000s, 100m, 10h, 1d , 1w
    # @param [String] filter_condition filters to be applied to metric values. For example, "column1 > 0", "column1 > 50 AND column2 = 10"
    # @param [Integer] limit a maximum number of returning values
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
  end
end
