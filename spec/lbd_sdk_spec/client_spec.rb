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

  let(:api_key) { 'dummy_api_key' }

  let(:api_secret_key) { 'dummy_secret_key' }

  it 'should be initialized' do
    expect(client.api_key).to be(api_key)
    expect(client.api_secret_key).to be(api_secret_key)
    expect(client.endpoint).to be(described_class::DEFAULT_ENDPOINT)
  end
end
