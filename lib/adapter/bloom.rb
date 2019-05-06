# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=10nlMGCmqcQGsTSePMgKooyBZA9_A5_52

module Adapter
  class Bloom
    BASE = 'https://www.bloomremit.net/api/v2/exchange_rates'
    AUTH = "?api_token=#{ENV['BLOOM_API_TOKEN']}&api_secret=#{ENV['BLOOM_API_SECRET']}"

    def rates(from, to)
      url = "#{BASE}/#{from}#{to}#{AUTH}"
      res = JSON.parse Faraday.get(url).body

      res.dig("#{from}#{to}").to_d
    rescue StandardError
      0
    end
  end
end
