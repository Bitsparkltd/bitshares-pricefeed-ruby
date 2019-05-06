# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1EIHzYq4afxHWdosbrd2cnDDCLaqeKj8k
# In free mode return only for USD
module Adapter
  class CurrencyLayer
    BASE = 'http://apilayer.net/api/live'
    AUTH = "?access_key=#{ENV['CURRENCYLAYER_API_KEY']}"

    def rates(from, _usd)
      url = "#{BASE}#{AUTH}&currencies=#{from}"
      res = JSON.parse Faraday.get(url).body

      res.dig('quotes', "USD#{from}").to_d
    rescue StandardError
      0
    end
  end
end
