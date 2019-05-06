# frozen_string_literal: true

# Available currencies
# https://drive.google.com/open?id=1hjO1-221MxLJi3VNHr4M7ofJnfgzsyAD

module Adapter
  class CoinGecko
    BASE   = 'https://api.coingecko.com/api/v3/simple/price'
    PARAMS = '?ids=bitshares&vs_currencies='

    def rates(from, _bitshares)
      url = "#{BASE}#{PARAMS}#{from}"
      res = JSON.parse Faraday.get(url).body

      res.dig('bitshares', from.downcase).to_d
    rescue StandardError
      0
    end
  end
end
