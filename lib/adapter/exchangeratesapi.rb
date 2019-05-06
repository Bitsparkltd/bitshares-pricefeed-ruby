# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=19YyeILB4DMGWnVrBN5nAIxSkYjV2PB-W

module Adapter
  class ExchangeRatesAPI
    BASE = 'https://api.exchangeratesapi.io/latest'

    def rates(from, to)
      url = "#{BASE}?base=#{to}&symbols=#{from}"
      res = JSON.parse Faraday.get(url).body
      res.dig('rates', from).to_d
    rescue StandardError
      0
    end
  end
end
