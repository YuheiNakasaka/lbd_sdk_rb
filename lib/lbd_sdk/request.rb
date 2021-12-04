# frozen_string_literal: true

module LbdSdk
  module Request
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
  
    def transfer_non_fungible_token_proxy_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def batch_transfer_non_fungible_token_proxy_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
  
      if !options[:transfer_list].nil? &&
          options[:transfer_list].is_a?(Array) && !options[:transfer_list].empty?
        params[:transferList] = options[:transfer_list].map do |option|
          {
            tokenId: option[:token_id] || option[:tokenId],
          }
        end
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def transfer_base_coin_request(options)
      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def transfer_service_token_request(options)
      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def transfer_fungible_token_request(options)
      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def transfer_non_fungible_token_request(options)
      params = {
        walletSecret: options[:wallet_secret],
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def batch_transfer_non_fungible_token_request(options)
      params = {
        walletSecret: options[:wallet_secret],
      }
  
      if !options[:transfer_list].nil? &&
          options[:transfer_list].is_a?(Array) && !options[:transfer_list].empty?
        params[:transferList] = options[:transfer_list].map do |option|
          {
            tokenId: option[:token_id] || option[:tokenId],
          }
        end
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def fungible_token_create_update_request(options)
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
  
    def non_fungible_token_create_update_request(options)
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
  
    def non_fungible_token_attach_request(options)
      params = {
        parentTokenId: options[:parent_token_id],
        serviceWalletAddress: options[:service_wallet_address],
        serviceWalletSecret: options[:service_wallet_secret],
      }
      if !options[:token_holder_address].nil?
        params[:tokenHolderAddress] = options[:token_holder_address]
      elsif !options[:token_holder_user_id].nil?
        params[:tokenHolderUserId] = options[:token_holder_user_id]
      else
        raise ArgumentError, 'token_holder_address or token_holder_user_id, one of them is required'
      end
      params
    end
  
    def non_fungible_token_detach_request(options)
      params = {
        serviceWalletAddress: options[:service_wallet_address],
        serviceWalletSecret: options[:service_wallet_secret],
      }
      if !options[:token_holder_address].nil?
        params[:tokenHolderAddress] = options[:token_holder_address]
      elsif !options[:token_holder_user_id].nil?
        params[:tokenHolderUserId] = options[:token_holder_user_id]
      else
        raise ArgumentError, 'token_holder_address or token_holder_user_id, one of them is required'
      end
      params
    end
  
    def fungible_token_mint_request(options)
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
  
    def fungible_token_burn_request(options)
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
  
    def non_fungible_token_mint_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        name: options[:name],
      }
  
      if !options[:meta].nil?
        params[:meta] = options[:meta]
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
      params
    end
  
    def non_fungible_token_multi_mint_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        mintList: options[:mint_list],
      }
  
      if !options[:mint_list].nil? && options[:mint_list].is_a?(Array) && !options[:mint_list].empty?
        params[:mintList] = options[:mint_list].map do |option|
          inner_params = {
            tokenType: option[:token_type],
            name: option[:name],
          }
    
          if !option[:meta].nil?
            inner_params[:meta] = option[:meta]
          end
  
          inner_params
        end
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      end
  
      params
    end
  
    def non_fungible_token_multi_mint_multi_recipients_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        mintList: options[:mint_list],
      }
  
      if !options[:mint_list].nil? && options[:mint_list].is_a?(Array) && !options[:mint_list].empty?
        params[:mintList] = options[:mint_list].map do |option|
          inner_params = {
            tokenType: option[:token_type],
            name: option[:name],
          }
  
          if !option[:meta].nil?
            inner_params[:meta] = option[:meta]
          end
  
          if !option[:to_user_id].nil?
            inner_params[:toUserId] = option[:to_user_id]
          elsif !option[:to_address].nil?
            inner_params[:toAddress] = option[:to_address]
          end
  
          inner_params
        end
      end
  
      params
    end
  
    def non_fungible_token_burn_request(options)
      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
      if !options[:from_user_id].nil?
        params[:fromUserId] = options[:from_user_id]
      elsif !options[:from_address].nil?
        params[:fromAddress] = options[:from_address]
      end
      params
    end
  
    def fungible_token_media_resources_request(options)
      params = {
        updateList: options[:update_list],
      }
  
      if !options[:update_list].nil? &&
          options[:update_list].is_a?(Array) && !options[:update_list].empty?
        params[:updateList] = options[:update_list].map do |option|
          {
            tokenType: option[:token_type] || option[:tokenType],
          }
        end
      end
  
      params
    end
  
    def non_fungible_token_media_resources_request(options)
      params = {
        updateList: options[:update_list],
      }
  
      if !options[:update_list].nil? &&
          options[:update_list].is_a?(Array) && !options[:update_list].empty?
        params[:updateList] = options[:update_list].map do |option|
          {
            tokenType: option[:token_type] || option[:tokenType],
            tokenIndex: option[:token_index] || option[:tokenIndex],
          }
        end
      end
  
      params
    end
  
    def memo_request(options)
      {
        walletAddress: options[:wallet_address],
        walletSecret: options[:wallet_secret],
        memo: options[:memo],
      }
    end
  end
end