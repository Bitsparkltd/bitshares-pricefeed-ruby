# frozen_string_literal: true

require_relative 'bitshares/client'

# Publishing price feeds to Bitshares based on price
# Account (aka producer) key should be added to Bitshares wallet
# 1.3.0 is BTS base currency ID
class Producer < Bitshares::Client
  attr_reader :price, :asset_symbol, :producer
  attr_reader :account, :asset, :base
  attr_reader :denominator, :numerator

  def initialize(price, asset_symbol, producer)
    @asset_symbol = asset_symbol
    @producer = producer

    rpc_initialize
    @price = price * 10 * 10**asset['precision'] / 10**base['precision']
    calculate_amounts
  end

  def rpc_initialize
    @account = rpc.get_account(producer)
    @asset   = rpc.get_asset(asset_symbol)
    @base    = rpc.get_asset('1.3.0')
  end

  def calculate_amounts
    @denominator = base['precision'] * 1000
    @numerator   = (price * denominator).round
  end

  def perform
    rpc.publish_asset_feed producer, asset['id'], price_feed, true
  end

  def price_feed
    {
      'settlement_price': settlement_hash,
      'core_exchange_rate': core_exchange_hash,
      'maintenance_collateral_ratio': ENV['MAINTENANCE_COLLATERAL_RATIO'],
      'maximum_short_squeeze_ratio': ENV['MAXIMUM_SHORT_SQUEEZE_RATIO']
    }
  end

  def settlement_hash
    {
      'quote': { 'asset_id': '1.3.0',
                 'amount': (denominator * ENV['CORE_EXCHANGE_RATE'].to_d).round },
      'base': { 'asset_id': asset['id'],
                'amount': numerator }
    }
  end

  def core_exchange_hash
    {
      'quote': { 'asset_id': '1.3.0',
                 'amount': denominator },
      'base': { 'asset_id': asset['id'],
                'amount': numerator }
    }
  end
end
