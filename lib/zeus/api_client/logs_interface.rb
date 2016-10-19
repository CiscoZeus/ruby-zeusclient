require 'zeus/api_client/rest_interface'
require 'zeus/api_client/result'

module Zeus
  module LogsInterface
    include RestInterface
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
    # @param [String] pattern a factor for filtering by name
    # @param [String] from_date a factor for filtering by start timestamp
    # @param [String] to_date a factor for filtering by end timestamp
    # @param [Integer] offset a factor for filtering by metrics name
    # @param [Integer] limit a maximum number of returning values
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
  end
end
