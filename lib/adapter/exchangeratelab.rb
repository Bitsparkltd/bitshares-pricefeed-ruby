# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1J3aYYlNlrl5bcfm4poUYfBu8CMj6mcff
module Adapter
  class ExchangeRateLab
    BASE = 'http://api.exchangeratelab.com/api/single/PHP'
    AUTH = "?apikey=#{ENV['EXCHANGERATE_LAB_API_KEY']}"

    def rates(from, _to)
      url = "#{BASE}/#{from}#{AUTH}"
      res = JSON.parse Faraday.get(url).body

      res.dig('rate', 'rate').to_d
    rescue StandardError
      0
    end
  end
end
