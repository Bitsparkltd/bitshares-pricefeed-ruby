# frozen_string_literal: true

require          'json'
require          'faraday'
require          'bigdecimal/util'
require          'dotenv/load'
require_relative 'producer'

Dir['./lib/adapter/*.rb'].each { |file| require file }

# Markets metadata
# https://drive.google.com/open?id=1DUBw1V9SKZ0yqam_9oWwtqDMW6tDR0XQ

class PriceFeed
  attr_reader :account

  def initialize(account = ENV['DEFAULT_ACCOUNT'])
    @account = account
  end

  def perform
    rates = [rates1, rates2, rates3, rates4, rates5, rates6]

    rates.keep_if(&:positive?)
    avg_rate = rates.sum / rates.count

    produce avg_rate
  end

  def rates1
    r1 = Adapter::Bloom.new.rates('PHP', 'BTC')
    r2 = rates_bts('BTC')

    return 0 if [r1, r2].any?(&:zero?)

    r1 / r2
  end

  def rates2
    r1 = Adapter::CoinsPH.new.rates('BTC', 'PHP')
    r2 = rates_bts('BTC')

    return 0 if [r1, r2].any?(&:zero?)

    (1 / r1) / r2
  end

  def rates3
    r1 = Adapter::ExchangeRatesAPI.new.rates('PHP', 'USD')
    r2 = rates_bts('USD')

    return 0 if [r1, r2].any?(&:zero?)

    (1 / r1) / r2
  end

  def rates4
    r1 = Adapter::Rebit.new.rates('PHP', nil) # BTC
    r2 = rates_bts('BTC')

    return 0 if [r1, r2].any?(&:zero?)

    (1 / r1) / r2
  end

  def rates5
    1 / (Adapter::CoinGecko.new.rates 'PHP', nil) # BTS
  rescue StandardError
    0
  end

  def rates6
    r1 = Adapter::CurrencyLayer.new.rates('PHP', nil) # USD
    r2 = rates_bts('USD')

    return 0 if [r1, r2].any?(&:zero?)

    (1 / r1) / r2
  end

  def rates_bts(btc_or_usd)
    res = Adapter::CoinGecko.new.rates btc_or_usd, 'BTS'
    res = Adapter::Coinigy.new.rates btc_or_usd, 'BTS' if res.zero?
    res
  end

  private

  def produce(price)
    pfeed = Producer.new price, ENV['ASSET_PHP'], account
    pfeed.perform
  end
end
