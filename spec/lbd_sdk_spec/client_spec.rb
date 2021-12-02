# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LbdSdk::Client do
  let(:client) do
    described_class.new do |config|
      config.endpoint = 'https://test-api.blockchain.line.me/'
      config.api_key = 'dummy_api_key'
      config.api_secret_key = 'dummy_secret_key'
    end
  end

  let(:api_key) do
    'dummy_api_key'
  end

  let(:api_secret_key) do
    'dummy_secret_key'
  end

  it 'should be initialized' do
    expect(client.api_key).to be(api_key)
    expect(client.api_secret_key).to be(api_secret_key)
    expect(client.endpoint).to be(described_class::DEFAULT_ENDPOINT)
  end

  describe '#time' do
    it 'should return time' do
      # VCR.use_cassette('time') do
      #   expect(client.time).to be_a(Time)
      # end
    end
  end
end
