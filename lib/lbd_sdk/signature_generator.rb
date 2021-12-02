# frozen_string_literal: true

require 'base64'
require 'openssl'

module LbdSdk
  class SignatureGenerator
    def generate(secret:, method:, endpoint_path:, timestamp:, nonce:, query_params: {}, body: {})
      sign_target = sign_target(
        method: method,
        endpoint_path: endpoint_path,
        timestamp: timestamp,
        nonce: nonce,
        query_params: query_params.merge(body),
      )

      sign_target += LbdSdk::RequestParamFlattener.new.flatten(query_params) unless query_params.empty?

      unless body.empty?
        sign_target += if query_params.empty?
                         RequestBodyFlattener.new.flatten(body)
                       else
                         "&#{RequestBodyFlattener.new.flatten(body)}"
                       end
      end

      raw_hmac = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha512'), secret, sign_target)
      Base64.strict_encode64(raw_hmac).strip
    end

    def sign_target(method:, endpoint_path:, timestamp:, nonce:, query_params: {})
      result = "#{nonce}#{timestamp}#{method}#{endpoint_path}"
      query_params.empty? ? result : "#{result}?"
    end
  end
end
