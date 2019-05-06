# frozen_string_literal: true

require 'jsonrpc-client'

module Bitshares
  class Client
    def rpc
      @rpc ||= JSONRPC::Client.new(ENV['BITSHARES_ENDPOINT'])
    end

    def unlock_rpc
      return unless rpc.is_locked

      rpc.set_password(ENV['BITSHARES_CLIENT_PASSWORD']) if rpc.is_new
      rpc.unlock(ENV['BITSHARES_CLIENT_PASSWORD'])
    end
  end
end
