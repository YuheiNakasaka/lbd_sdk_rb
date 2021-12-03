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

    def user_transactions(user_id, query_params = {})
      get("/v1/users/#{user_id}/transactions", query_params: transaction_page_request(query_params))
    end

    def base_coin_balance_of_user(user_id)
      get("/v1/users/#{user_id}/base-coin")
    end

    def service_token_balances_of_user(user_id, query_params = {})
      get("/v1/users/#{user_id}/service-tokens", query_params: page_request(query_params))
    end

    def service_token_balance_of_user(user_id, contract_id)
      get("/v1/users/#{user_id}/service-tokens/#{contract_id}")
    end

    def fungible_token_balances_of_user(user_id, contractId, query_params = {})
      get("/v1/users/#{user_id}/item-tokens/#{contractId}/fungibles", query_params: page_request(query_params))
    end

    def fungible_token_balance_of_user(user_id, contractId, token_type)
      get("/v1/users/#{user_id}/item-tokens/#{contractId}/fungibles/#{token_type}")
    end

    def non_fungible_token_balances_of_user(user_id, contractId, query_params = {})
      get("/v1/users/#{user_id}/item-tokens/#{contractId}/non-fungibles", query_params: page_request(query_params))
    end

    def non_fungible_token_balances_by_type_of_user(user_id, contractId, token_type, query_params = {})
      get("/v1/users/#{user_id}/item-tokens/#{contractId}/non-fungibles/#{token_type}", query_params: page_request(query_params))
    end

    def non_fungible_token_balance_of_user(user_id, contractId, token_type, token_index)
      get("/v1/users/#{user_id}/item-tokens/#{contractId}/non-fungibles/#{token_type}/#{token_index}")
    end

    def retrieve_session_token_status(request_session_token)
      get("/v1/user-requests/#{request_session_token}")
    end

    def issue_session_token_for_base_coin_transfer(user_id, request_type, payload = {})
      post("/v1/users/#{user_id}/base-coin/request-transfer", query_params: {requestType: request_type}, payload: issue_transfer_session_token_request(payload))
    end

    def issue_session_token_for_service_token_transfer(user_id, contract_id, request_type, payload = {})
      post("/v1/users/#{user_id}/service-tokens/#{contract_id}/request-transfer", query_params: {requestType: request_type}, payload: issue_transfer_session_token_request(payload))
    end

    def issue_service_token_proxy_request(user_id, contract_id, request_type, payload = {})
      post("/v1/users/#{user_id}/service-tokens/#{contract_id}/request-proxy", query_params: {requestType: request_type}, payload: user_proxy_request(payload))
    end

    def issue_item_token_proxy_request(user_id, contract_id, request_type, payload = {})
      post("/v1/users/#{user_id}/item-tokens/#{contract_id}/request-proxy", query_params: {requestType: request_type}, payload: user_proxy_request(payload))
    end

    def commit_proxy_request(request_session_token)
      post("/v1/user-requests/#{request_session_token}/commit")
    end

    def transfer_service_token_of_user(user_id, contract_id, payload = {})
      post("/v1/users/#{user_id}/service-tokens/#{contract_id}/transfer", payload: transfer_service_token_proxy_request(payload))
    end

    def transfer_fungible_token_of_user(user_id, contract_id, token_type, payload = {})
      post("/v1/users/#{user_id}/item-tokens/#{contract_id}/fungibles/#{token_type}/transfer", payload: transfer_fungible_token_proxy_request(payload))
    end

    def service_token_proxy_status_of_user(user_id, contract_id)
      get("/v1/users/#{user_id}/service-tokens/#{contract_id}/proxy")
    end

    def item_token_proxy_status_of_user(user_id, contract_id)
      get("/v1/users/#{user_id}/item-tokens/#{contract_id}/proxy")
    end

    def wallets()
      get('/v1/wallets')
    end

    def wallet_detail(wallet_address)
      get("/v1/wallets/#{wallet_address}")
    end

    def wallet_transactions(wallet_address, query_params = {})
      get("/v1/wallets/#{wallet_address}/transactions", query_params: transaction_page_request(query_params))
    end

    def base_coin_balance_of_wallet(wallet_address)
      get("/v1/wallets/#{wallet_address}/base-coin")
    end

    def service_token_balances_of_wallet(wallet_address, query_params = {})
      get("/v1/wallets/#{wallet_address}/service-tokens", query_params: page_request(query_params))
    end

    def service_token_balance_of_wallet(wallet_address, contract_id)
      get("/v1/wallets/#{wallet_address}/service-tokens/#{contract_id}")
    end

    def fungible_token_balances_of_wallet(wallet_address, contract_id, query_params = {})
      get("/v1/wallets/#{wallet_address}/item-tokens/#{contract_id}/fungibles", query_params: page_request(query_params))
    end

    def fungible_token_balance_of_wallet(wallet_address, contract_id, tokenType)
      get("/v1/wallets/#{wallet_address}/item-tokens/#{contract_id}/fungibles/#{tokenType}")
    end

    def non_fungible_token_balances_of_wallet(wallet_address, contract_id, query_params = {})
      get("/v1/wallets/#{wallet_address}/item-tokens/#{contract_id}/non-fungibles", query_params: page_request(query_params))
    end

    def non_fungible_token_balances_by_type_of_wallet(wallet_address, contract_id, token_type, query_params = {})
      get("/v1/wallets/#{wallet_address}/item-tokens/#{contract_id}/non-fungibles/#{token_type}", query_params: page_request(query_params))
    end

    def non_fungible_token_balance_of_wallet(wallet_address, contract_id, token_type, token_index)
      get("/v1/wallets/#{wallet_address}/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{token_index}")
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

    def update_service_token(contract_id, payload = {})
      put("/v1/service-tokens/#{contract_id}", payload: update_service_token_request(payload))
    end

    def mint_service_token(contract_id, payload = {})
      post("/v1/service-tokens/#{contract_id}/mint", payload: mint_service_token_request(payload))
    end

    def burn_from_service_token(contract_id, payload = {})
      post("/v1/service-tokens/#{contract_id}/burn-from", payload: burn_from_service_token_request(payload))
    end

    def service_token_holders(contract_id, query_params = {})
      get("/v1/service-tokens/#{contract_id}/holders", query_params: page_request(query_params))
    end

    def item_token(contract_id)
      get("/v1/item-tokens/#{contract_id}")
    end

    def fungible_tokens(contract_id, query_params = {})
      get("/v1/item-tokens/#{contract_id}/fungibles", query_params: page_request(query_params))
    end

    def fungible_token(contract_id, token_type)
      get("/v1/item-tokens/#{contract_id}/fungibles/#{token_type}")
    end

    def fungible_token_holders(contract_id, token_type, query_params = {})
      get("/v1/item-tokens/#{contract_id}/fungibles/#{token_type}/holders", query_params: page_request(query_params))
    end

    def non_fungible_tokens(contract_id, query_params = {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles", query_params: page_request(query_params))
    end

    def non_fungible_token_type(contract_id, token_type, query_params = {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}", query_params: page_request(query_params))
    end

    def non_fungible_token(contract_id, token_type, tokenIndex)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{tokenIndex}")
    end

    def non_fungible_token_type_holders(contract_id, token_type, query_params = {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/holders", query_params: page_request(query_params))
    end

    def non_fungible_token_holder(contract_id, token_type, token_index)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{token_index}/holder")
    end

    def children_of_non_fungible_token(contract_id, token_type, tokenIndex, query_params = {})
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{tokenIndex}/children", query_params: page_request(query_params))
    end

    def parent_of_non_fungible_token(contract_id, token_type, tokenIndex)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{tokenIndex}/parent")
    end

    def root_of_non_fungible_token(contract_id, token_type, tokenIndex)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/#{token_type}/#{tokenIndex}/root")
    end

    def fungible_token_media_resources_update_status(contract_id, request_id)
      get("/v1/item-tokens/#{contract_id}/fungibles/icon/#{request_id}/status")
    end

    def non_fungible_token_media_resources_update_status(contract_id, request_id)
      get("/v1/item-tokens/#{contract_id}/non-fungibles/icon/#{request_id}/status")
    end

    def memos(tx_hash)
      get("/v1/memos/#{tx_hash}")
    end

    def transaction_result(tx_hash)
      get("/v1/transactions/#{tx_hash}")
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

    def post(endpoint_path, query_params: {}, payload: {})
      headers = request_headers(endpoint_path: endpoint_path, method: 'POST', query_params: query_params, payload: payload)
      query_params = RequestParamFlattener.new.flatten(query_params)
      if query_params.empty?
        httpclient.post("#{@endpoint}#{endpoint_path}", payload.to_json, headers)
      else
        httpclient.post("#{@endpoint}#{endpoint_path}?#{query_params}", payload.to_json, headers)
      end
    end

    def put(endpoint_path, payload: {})
      headers = request_headers(endpoint_path: endpoint_path, method: 'PUT', payload: payload)
      httpclient.put("#{@endpoint}#{endpoint_path}", payload.to_json, headers)
    end

    def request_headers(endpoint_path:, method:, query_params: {}, payload: {})
      nonce = rand(10_000_000..99_999_999)
      timestamp = (Time.now.utc.to_f * 1000).round
      method = method.to_s.upcase
      {
        'service-api-key': @api_key,
        'Content-Type': 'application/json',
        Nonce: "#{nonce}",
        Timestamp: "#{timestamp}",
        Signature: SignatureGenerator.new.generate(
          secret: @api_secret_key,
          method: method,
          endpoint_path: endpoint_path,
          timestamp: timestamp,
          nonce: nonce,
          query_params: query_params,
          body: payload,
        ),
      }
    end

    def page_request(options)
      {
        limit: options[:limit] || 10,
        page: options[:page] || 1,
        orderBy: options[:order_by] || 'desc',
      }
    end

    def transaction_page_request(options)
      params = {
        limit: options[:limit] || 10,
        page: options[:page] || 1,
        orderBy: options[:order_by] || 'desc',
      }
      if !options[:before].nil?
        params[:before] = options[:before]
      end
      if !options[:after].nil?
        params[:after] = options[:after]
      end
      if !options[:msgType].nil?
        params[:msgType] = options[:msgType]
      end
      params
    end

    def update_service_token_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
      if !options[:name].nil?
        params[:name] = options[:name]
      end
      if !options[:meta].nil?
        params[:meta] = options[:meta]
      end
      params
    end

    def mint_service_token_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end

    def burn_from_service_token_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:from_user_id].nil?
        params[:fromUserId] = options[:from_user_id]
      elsif !options[:from_address].nil?
        params[:fromAddress] = options[:from_address]
      end
      params
    end

    def user_proxy_request(options)
      {
        ownerAddress: options[:owner_address],
        landingUri: options[:landing_uri],
      }
    end

    def issue_transfer_session_token_request(options)
      params = {
        amount: options[:amount].to_s,
        landingUri: options[:landing_uri],
      }

      if params[:amount].to_i <= 0
        raise ArgumentError, 'Invalid amount - $amount is less than zero '
      end

      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end

    def transfer_service_token_proxy_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end

    def transfer_fungible_token_proxy_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  end
end
