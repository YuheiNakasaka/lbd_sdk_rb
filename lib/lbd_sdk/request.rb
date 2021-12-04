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
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

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
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def burn_from_service_token_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:from_user_id].nil?
        params[:fromUserId] = options[:from_user_id]
      elsif !options[:from_address].nil?
        params[:fromAddress] = options[:from_address]
      else
        raise ArgumentError, 'from_user_id or from_address is required'
      end
      params
    end
  
    def user_proxy_request(options)
      if options[:owner_address].nil?
        raise ArgumentError, 'owner_address is required'
      end

      params = {
        ownerAddress: options[:owner_address],
      }
      if !options[:landing_uri].nil?
        params[:landingUri] = options[:landing_uri]
      end
      params
    end
  
    def issue_transfer_session_token_request(options)
      if options[:amount].nil?
        raise ArgumentError, 'amount is required'
      elsif options[:amount].to_i <= 0
        raise ArgumentError, 'Invalid amount - $amount is less than zero'
      end

      params = {
        amount: options[:amount].to_s,
      }
  
      if !options[:landing_uri].nil?
        params[:landingUri] = options[:landing_uri]
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_service_token_proxy_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_fungible_token_proxy_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_non_fungible_token_proxy_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def batch_transfer_non_fungible_token_proxy_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

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
      else
        raise ArgumentError, 'transfer_list is inappropriate'
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_base_coin_request(options)
      if options[:wallet_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'amount and wallet_secret are required'
      end

      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_service_token_request(options)
      if options[:wallet_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'amount and wallet_secret are required'
      end

      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }

      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_fungible_token_request(options)
      if options[:wallet_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'amount and wallet_secret are required'
      end

      params = {
        walletSecret: options[:wallet_secret],
        amount: options[:amount].to_s,
      }

      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def transfer_non_fungible_token_request(options)
      if options[:wallet_secret].nil?
        raise ArgumentError, 'wallet_secret is required'
      end

      params = {
        walletSecret: options[:wallet_secret],
      }
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def batch_transfer_non_fungible_token_request(options)
      if options[:wallet_secret].nil?
        raise ArgumentError, 'wallet_secret are required'
      end

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
      else
        raise ArgumentError, 'transfer_list is inappropriate'
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def fungible_token_create_update_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:name].nil?
        raise ArgumentError, 'owner_address and owner_secret and name are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        name: options[:name],
      }

      if !options[:meta].nil?
        params[:meta] = options[:meta]
      end
      params
    end
  
    def non_fungible_token_create_update_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:name].nil?
        raise ArgumentError, 'owner_address and owner_secret and name are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        name: options[:name],
      }

      if !options[:meta].nil?
        params[:meta] = options[:meta]
      end
      params
    end
  
    def non_fungible_token_attach_request(options)
      if options[:parent_token_id].nil? || options[:service_wallet_address].nil? || options[:service_wallet_secret].nil?
        raise ArgumentError, 'parent_token_id and service_wallet_address and service_wallet_secret are required'
      end

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
      if options[:service_wallet_address].nil? || options[:service_wallet_secret].nil?
        raise ArgumentError, 'service_wallet_address and service_wallet_secret are required'
      end

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
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }

      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def fungible_token_burn_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:amount].nil?
        raise ArgumentError, 'owner_address and owner_secret and amount are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        amount: options[:amount].to_s,
      }

      if !options[:from_user_id].nil?
        params[:fromUserId] = options[:from_user_id]
      elsif !options[:from_address].nil?
        params[:fromAddress] = options[:from_address]
      else
        raise ArgumentError, 'from_user_id or from_address is required'
      end
      params
    end
  
    def non_fungible_token_mint_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil? || options[:name].nil?
        raise ArgumentError, 'owner_address and owner_secret and name are required'
      end

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
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
      params
    end
  
    def non_fungible_token_multi_mint_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        mintList: options[:mint_list],
      }
  
      if !options[:mint_list].nil? && options[:mint_list].is_a?(Array) && !options[:mint_list].empty?
        params[:mintList] = options[:mint_list].map do |option|
          if option[:token_type].nil? || option[:name].nil?
            raise ArgumentError, 'token_type and name are required'
          end

          inner_params = {
            tokenType: option[:token_type],
            name: option[:name],
          }
    
          if !option[:meta].nil?
            inner_params[:meta] = option[:meta]
          end
  
          inner_params
        end
      else
        raise ArgumentError, 'mint_list is required and must be an Array'
      end
  
      if !options[:to_user_id].nil?
        params[:toUserId] = options[:to_user_id]
      elsif !options[:to_address].nil?
        params[:toAddress] = options[:to_address]
      else
        raise ArgumentError, 'to_user_id or to_address is required'
      end
  
      params
    end
  
    def non_fungible_token_multi_mint_multi_recipients_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
        mintList: options[:mint_list],
      }
  
      if !options[:mint_list].nil? && options[:mint_list].is_a?(Array) && !options[:mint_list].empty?
        params[:mintList] = options[:mint_list].map do |option|
          if option[:token_type].nil? || option[:name].nil?
            raise ArgumentError, 'token_type and name are required'
          end

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
          else
            raise ArgumentError, 'to_user_id or to_address is required'
          end
  
          inner_params
        end
      else
        raise ArgumentError, 'mint_list is required and must be an Array'
      end
  
      params
    end
  
    def non_fungible_token_burn_request(options)
      if options[:owner_address].nil? || options[:owner_secret].nil?
        raise ArgumentError, 'owner_address and owner_secret are required'
      end

      params = {
        ownerAddress: options[:owner_address],
        ownerSecret: options[:owner_secret],
      }
      if !options[:from_user_id].nil?
        params[:fromUserId] = options[:from_user_id]
      elsif !options[:from_address].nil?
        params[:fromAddress] = options[:from_address]
      else
        raise ArgumentError, 'from_user_id or from_address is required'
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
          if option[:token_type].nil? && option[:tokenType].nil?
            raise ArgumentError, 'token_type is required'
          end
          {
            tokenType: option[:token_type] || option[:tokenType],
          }
        end
      else
        raise ArgumentError, 'update_list is required and must be an Array'
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
          if option[:token_type].nil? && option[:tokenType].nil?
            raise ArgumentError, 'token_type is required'
          elsif option[:token_index].nil? && option[:tokenIndex].nil?
            raise ArgumentError, 'token_index is required'
          end

          {
            tokenType: option[:token_type] || option[:tokenType],
            tokenIndex: option[:token_index] || option[:tokenIndex],
          }
        end
      else
        raise ArgumentError, 'update_list is required and must be an Array'
      end
  
      params
    end
  
    def memo_request(options)
      if options[:wallet_address].nil? || options[:wallet_secret].nil? || options[:memo].nil?
        raise ArgumentError, 'wallet_address and wallet_secret and memo are required'
      end

      {
        walletAddress: options[:wallet_address],
        walletSecret: options[:wallet_secret],
        memo: options[:memo],
      }
    end
  end
end