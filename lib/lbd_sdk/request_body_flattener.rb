# frozen_string_literal: true

module LbdSdk
  class RequestBodyFlattener
    def flatten(body = {})
      if body.empty?
        ''
      else
        body.sort.map { |key, value| flatten_key_value(key, value) }.join('&')
      end
    end

    def flatten_key_value(key, value)
      return "#{key}=#{value}" if value.is_a?(String)

      if value.is_a?(Object)
        l_key_value = {}
        value.each.with_index do |elm, i|
          (l_key_value.keys | elm.keys).each do |lkey|
            l_value = ''
            l_value = elm[lkey] if elm.keys.include?(lkey)
            l_key_value[lkey] = if l_key_value.keys.include?(lkey)
                                  "#{l_key_value[lkey]},#{l_value}"
                                else
                                  "#{',' * i}#{l_value}"
                                end
          end
        end
        l_key_value.sort.map { |lkey, lvalue| "#{key}.#{lkey}=#{lvalue}" }.join('&')
      end
    end
  end
end
