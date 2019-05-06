# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1Hh8uS4RVncxO33ug2ASTt7bkAoDrl48-

module Adapter
  class Rebit
    BASE = 'https://rebit.ph/api/v1/rates'

    def rates(from, _usd_or_btc)
      url = BASE
      res = JSON.parse Faraday.get(url).body

      res.dig(from).to_d # BTC
    rescue StandardError
      0
    end
  end
end
