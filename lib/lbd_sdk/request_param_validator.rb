# frozen_string_literal: true

module LbdSdk
  module RequestParamValidator
    WALLET_ADDRESS_REGEX = '^t?link[a-zA-Z0-9]{39}$'
    TOKEN_NAME_REGEX = '^[a-zA-Z0-9]{3,20}$'
    SYMBOL_NAME_REGEX = '^[A-Z][A-Z0-9]{1,4}$'
    NUMBER_FORMAT_REGEX = '^\d+$'
    BASE_URI_OR_EMPTY_REGEX = '^(^(https:\/\/)[\w\.\-\~\/]+(:[0-9]{1,5})?\/$)?$'

    def is_valid_wallet_address(wallet_address)
      wallet_address.to_s.match?(/#{WALLET_ADDRESS_REGEX}/)
    end

    def is_valid_token_name(name)
      name.to_s.match?(/#{TOKEN_NAME_REGEX}/)
    end

    def is_valid_symbol(symbol)
      symbol.to_s.match?(/#{SYMBOL_NAME_REGEX}/)
    end

    def is_valid_initial_supply(initial_supply)
      initial_supply.to_s.match?(/#{NUMBER_FORMAT_REGEX}/)
    end

    def is_valid_base_uri(base_uri)
      base_uri.to_s.match?(/#{BASE_URI_OR_EMPTY_REGEX}/)
    end
  end
end
