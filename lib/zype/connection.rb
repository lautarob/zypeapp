require 'faraday'
require 'json'

class Connection
  BASE = ENV['ZYPE_API_URL']

  def self.api
    Faraday.new(url: BASE) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.params[:app_key] = ENV['ZYPE_API_APP_KEY']
      faraday.headers['Content-Type'] = 'application/json'
    end
  end
end
