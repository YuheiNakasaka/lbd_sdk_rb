require 'json'
require 'net/http'
require 'uri'

module LbdSdk
  class HTTPClient
    # @return [Hash]
    attr_accessor :http_options

    # Initialize a new HTTPClient
    #
    # @param http_options [Hash]
    #
    # @return [LbdSdk::HTTPClient]
    def initialize(http_options = {})
      @http_options = http_options
    end

    # @return [Net::HTTP]
    def http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      http_options&.each { |key, value| http.send("#{key}=", value) }

      http
    end

    def get(url, header = {})
      uri = URI(url)
      http(uri).get(uri.request_uri, header)
    end

    def post(url, payload, header = {})
      uri = URI(url)
      http(uri).post(uri.request_uri, payload, header)
    end

    def put(url, payload, header = {})
      uri = URI(url)
      http(uri).put(uri.request_uri, payload, header)
    end

    def delete(url, payload = {}, header = {})
      uri = URI(url)
      http = http(uri)
      request = Net::HTTP::Delete.new(uri.request_uri, header)
      request.body = payload
      http.request(request)
    end
  end
end
