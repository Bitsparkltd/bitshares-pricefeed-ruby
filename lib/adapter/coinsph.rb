# frozen_string_literal: true

# Available pairs
# https://drive.google.com/open?id=1Pc5cdeRwD9udfxN5xbnnOtnda9UKleso

module Adapter
  class CoinsPH
    BASE = 'https://quote.coins.ph/v1/markets'

    def rates(from, to)
      url = "#{BASE}/#{from}-#{to}"
      res = JSON.parse Faraday.get(url).body

      ask = res.dig('market', 'ask').to_d
      bid = res.dig('market', 'bid').to_d

      (ask + bid) / 2
    rescue StandardError
      0
    end
  end
end
