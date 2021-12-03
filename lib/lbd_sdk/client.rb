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

    def user_detail(user_id)
      get("/v1/users/#{user_id}")
    end

    def service_detail(service_id)
      get("/v1/services/#{service_id}")
    end

    def service_tokens()
      get('/v1/service-tokens')
    end

    def service_token_detail(contract_id)
      get("/v1/service-tokens/#{contract_id}")
    end

    def service_token_holders(contract_id, query_params: {})
      get("/v1/service-tokens/#{contract_id}/holders", query_params: page_request(query_params))
    end

    def item_token(contract_id)
      get("/v1/item-tokens/#{contract_id}")
    end

    def fungible_tokens(contract_id, query_params: {})
      get("/v1/item-tokens/#{contract_id}/fungibles", query_params: page_request(query_params))
    end

    def fungible_token(contract_id, token_type)
      get("/v1/item-tokens/#{contract_id}/fungibles/#{token_type}")
    end

    def fungible_token_holders(contract_id, token_type, query_params: {})
      get("/v1/item-tokens/#{contract_id}/fungibles/#{token_type}/holders", query_params: page_request(query_params))
    end

    def non_fungible_tokens(contract_id, query_params: {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles", query_params: page_request(query_params))
    end

    def non_fungible_token_type(contract_id, token_type, query_params: {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}", query_params: page_request(query_params))
    end

    def non_fungible_token(contract_id, token_type, tokenIndex)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{tokenIndex}")
    end

    def non_fungible_token_type_holders(contract_id, token_type, query_params: {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/holders", query_params: page_request(query_params))
    end

    def non_fungible_token_holder(contract_id, token_type, token_index)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{token_index}/holder")
    end

    def httpclient
      HTTPClient.new
    end

    def get(endpoint_path, query_params: {})
      headers = request_headers(endpoint_path: endpoint_path, method: 'GET', query_params: query_params)
      query_params = RequestParamFlattener.new.flatten(query_params)
      if query_params.empty?
        httpclient.get("#{@endpoint}#{endpoint_path}", headers)
      else
        httpclient.get("#{@endpoint}#{endpoint_path}?#{query_params}", headers)
      end
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

    def page_request(options)
      {
        limit: options[:limit] || 10,
        page: options[:page] || 1,
        orderBy: options[:order_by] || 'desc',
      }
    end
  end
end
