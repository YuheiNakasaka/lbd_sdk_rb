# frozen_string_literal: true

module LbdSdk
  class RequestParamFlattener
    def flatten(params = {})
      params.empty? ? '' : params.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
