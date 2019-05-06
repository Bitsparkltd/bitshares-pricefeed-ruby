# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1TAQ5xKKHqo403ENWB4CWe0JefLvlhZR9

module Adapter
  class XE
    BASE = 'https://xecdapi.xe.com/v1/convert_to.json'

    def rates(from, to)
      @url = "#{BASE}?from=#{from}&to=#{to}&amount=1"
      res = JSON.parse connection.get.body
      res.dig('from', 0, 'mid').to_d
    rescue StandardError
      0
    end

    def connection
      Faraday.new(@url) do |conn|
        conn.adapter Faraday.default_adapter
        conn.basic_auth(ENV['XE_ACCOUNT_ID'], ENV['XE_API_KEY'])
      end
    end
  end
end
