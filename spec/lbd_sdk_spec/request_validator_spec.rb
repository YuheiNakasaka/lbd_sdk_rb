# frozen_string_literal: true

require 'spec_helper'
require 'lbd_sdk/request_param_validator'

class DummyClass
  include LbdSdk::RequestParamValidator
end

RSpec.describe LbdSdk::RequestParamValidator do
  let(:instance) { DummyClass.new }

  describe '#is_valid_wallet_address' do
    it 'returns true for valid wallet address' do
      address = 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(instance.is_valid_wallet_address(address)).to eq(true)
    end

    it 'returns false for invalid wallet address' do
      expect(instance.is_valid_wallet_address('aaa')).to eq(false)
    end
  end

  describe '#is_valid_token_name' do
    it 'returns true for valid token name' do
      name = 'abc'
      expect(instance.is_valid_token_name(name)).to eq(true)
    end

    it 'returns true for valid token name' do
      name = 'aaaaaaaaaaaaaaaaaaaa'
      expect(instance.is_valid_token_name(name)).to eq(true)
    end

    it 'returns false for too short token name' do
      expect(instance.is_valid_token_name('ab')).to eq(false)
    end

    it 'returns false for too long token name' do
      expect(instance.is_valid_token_name('aaaaaaaaaaaaaaaaaaaaa')).to eq(false)
    end
  end

  describe '#is_valid_symbol' do
    it 'returns true for valid symbol' do
      expect(instance.is_valid_symbol('AB')).to eq(true)
    end

    it 'returns true for valid symbol' do
      expect(instance.is_valid_symbol('ABBBB')).to eq(true)
    end

    it 'returns false for too short symbol' do
      expect(instance.is_valid_symbol('A')).to eq(false)
    end

    it 'returns false for too long symbol' do
      expect(instance.is_valid_symbol('AAAAAA')).to eq(false)
    end
  end

  describe '#is_valid_initial_supply' do
    it 'returns true for valid supply' do
      expect(instance.is_valid_initial_supply('1')).to eq(true)
    end

    it 'returns false for invalid supply' do
      expect(instance.is_valid_initial_supply('A')).to eq(false)
    end
  end

  describe '#is_valid_base_uri' do
    it 'returns true for valid uri' do
      base_uri = 'https://test-image-server.com:3000/'
      expect(instance.is_valid_base_uri(base_uri)).to eq(true)
    end

    it 'returns false for invalid protocol uri' do
      base_uri = 'https://test-image-server:3000.com/'
      expect(instance.is_valid_base_uri(base_uri)).to eq(false)
    end

    it 'returns false for invalid empty uri' do
      base_uri = ''
      expect(instance.is_valid_base_uri(base_uri)).to eq(true)
    end
  end
end
