module LbdSdk
  module HashConverter
    def camelize(hash)
      hash.each_with_object({}) do |(key, value), new_hash|
        lower_case_key =
          key
            .to_s
            .split('_')
            .map(&:capitalize)
            .join
            .sub(/./) { $&.downcase }
            .to_sym
        new_hash[lower_case_key] = value.is_a?(Hash) ? camelize(value) : value
      end
    end
  end
end
