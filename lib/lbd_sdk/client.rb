# frozen_string_literal: true

require 'base64'
require 'net/http'
require 'openssl'
require 'uri'

module LbdSdk
  # Client for the LINE Blockchain API
  #
  # @client ||= LbdSdk::Client.new do |config|
  #   config.endpoint = 'https://test-api.blockchain.line.me/'
  #   config.api_key = 'your_api_key'
  #   config.api_secret_key = 'your_secret_key'
  # end
  class Client
    attr_accessor :endpoint, :api_key, :api_secret_key

    DEFAULT_ENDPOINT = 'https://test-api.blockchain.line.me/'

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?

      @endpoint ||= DEFAULT_ENDPOINT
    end

    def time
      get('/v1/time')
    end

    def httpclient
      HTTPClient.new
    end

    def get(endpoint_path, query_params: {})
      headers = request_headers(endpoint_path: endpoint_path, method: 'GET', query_params: query_params)
      puts "#{@endpoint + endpoint_path}, #{headers}"
      httpclient.get(@endpoint + endpoint_path, headers)
    end

    def request_headers(endpoint_path:, method:, query_params: {}, body: {})
      nonce = rand(10_000_000..99_999_999)
      timestamp = (Time.now.utc.to_f * 1000).round
      method = method.to_s.upcase
      {
        'service-api-key': @api_key,
        Nonce: "#{nonce}",
        Timestamp: "#{timestamp}",
        Signature: SignatureGenerator.new.generate(
          secret: @api_secret_key,
          method: method,
          endpoint_path: endpoint_path,
          timestamp: timestamp,
          nonce: nonce,
          query_params: query_params,
          body: body,
        )
      }
    end
  end
end
