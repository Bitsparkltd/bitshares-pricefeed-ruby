# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1Pc5cdeRwD9udfxN5xbnnOtnda9UKleso
# In free mode return only for EUR

module Adapter
  class Fixer
    BASE = 'http://data.fixer.io/api/latest'
    AUTH = "?access_key=#{ENV['FIXER_API_KEY']}"

    def rates(from, _eur)
      url = "#{BASE}#{AUTH}&symbols=#{from}"
      res = JSON.parse Faraday.get(url).body

      res.dig('rates', 'PHP').to_d
    rescue StandardError
      0
    end
  end
end
