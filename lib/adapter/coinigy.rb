# frozen_string_literal: true

# Available pairs
# https://drive.google.com/open?id=19tUcUHqlbZWWA8aSfuQEm7bfpXfibuf9
# https://drive.google.com/open?id=1_ww52VraM7rTkid7mVoyMEtc1FyZQgKJ

module Adapter
  class Coinigy
    BASE = 'https://api.coinigy.com/api/v2/public/convert'

    def rates(from, to)
      url = "#{BASE}/#{to}/#{from}"
      res = JSON.parse Faraday.get(url).body

      res.dig('result').to_d
    rescue StandartError
      0
    end
  end
end
