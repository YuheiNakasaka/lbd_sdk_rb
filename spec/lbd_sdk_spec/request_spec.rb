# frozen_string_literal: true

require 'spec_helper'
require 'lbd_sdk/request'

class DummyClass
  include LbdSdk::Request
end

RSpec.describe LbdSdk::Request do
  let(:instance) { DummyClass.new }

  describe '#page_request' do
    it 'returns a default hash' do
      expect(instance.page_request({})).to eq(
        { limit: 10, page: 1, orderBy: 'desc' },
      )
    end

    it 'should be set arbitrary params' do
      expect(
        instance.page_request({ limit: 1, page: 2, order_by: 'asc' }),
      ).to eq({ limit: 1, page: 2, orderBy: 'asc' })
    end
  end

  describe '#cursor_page_request' do
    it 'returns a default hash' do
      expect(instance.cursor_page_request({})).to eq(
        { limit: 10, orderBy: 'desc', pageToken: '' },
      )
    end

    it 'should be set arbitrary params' do
      pageToken =
        'eJxtzk0PgjAMBuD/0jMHESXoDQETYoJGd9ATWbYuEnDAmAQk/HfnZzzYU/ukfdMBKOcKm8aXPCilVpTp2HRFgUxnpUyEXmeFRgXL4bMKS9BFJnM7rx1Ptfx661rnush7wRhdVBd0WYVdPavPSL2uBQvYN9nc2p4n3LkjYLSgVBzVqjcabBOy9wOSxmEaRocgJdtNlKTktIt+5zgJo+MTTCwV78f+51ugyxwl6St88ORZ9odjybEz/uKpDeN4BzAdV4M=' # rubocop:disable Layout/LineLength
      expect(
        instance.cursor_page_request(
          { limit: 1, order_by: 'asc', page_token: pageToken },
        ),
      ).to eq({ limit: 1, orderBy: 'asc', pageToken: pageToken })
    end
  end

  describe '#transaction_page_request' do
    it 'returns a default hash' do
      expect(instance.transaction_page_request({})).to eq(
        { limit: 10, page: 1, orderBy: 'desc' },
      )
    end

    it 'should be set arbitrary params' do
      timestamp = (Time.now.to_f * 1000).round
      expect(
        instance.transaction_page_request(
          {
            limit: 1,
            page: 2,
            order_by: 'asc',
            before: timestamp,
            after: timestamp,
            msg_type: 'coin/MsgSend',
          },
        ),
      ).to eq(
        {
          limit: 1,
          page: 2,
          orderBy: 'asc',
          before: timestamp,
          after: timestamp,
          msgType: 'coin/MsgSend',
        },
      )
    end
  end

  describe '#issue_service_token_request' do
    before do
      @payload = {
        service_wallet_address: 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        service_wallet_secret: 'secret',
        name: 'abc',
        symbol: 'ABCDE',
        initial_supply: '1234567890',
        recipient_wallet_address:
          'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab',
        img_uri: 'https://example.com/',
      }

      @camelized_payload = {
        serviceWalletAddress: 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        serviceWalletSecret: 'secret',
        name: 'abc',
        symbol: 'ABCDE',
        initialSupply: '1234567890',
        recipientWalletAddress: 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab',
        imgUri: 'https://example.com/',
      }
    end
    it 'returns valid request hash' do
      expect(instance.issue_service_token_request(@payload)).to eq(
        @camelized_payload,
      )
    end

    it 'throws argument error' do
      @payload[:service_wallet_address] = nil
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:service_wallet_secret] = nil
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:service_wallet_address] = 'invalid'
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:name] = ''
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:symbol] = 'A'
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:initial_supply] = 'A'
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:recipient_wallet_address] = 'invalid'
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end

    it 'throws argument error' do
      @payload[:img_uri] = 'https://example.com/hoge.png'
      expect { instance.issue_service_token_request(@payload) }.to raise_error(
        ArgumentError,
      )
    end
  end

  describe '#issued_service_token_by_tx_hash_request' do
    before do
      @payload = { is_only_contract_id: true }
      @camelized_payload = { isOnlyContractId: false }
    end
    it 'returns valid request hash' do
      expect(instance.issued_service_token_by_tx_hash_request({})).to eq(
        @camelized_payload,
      )
    end

    it 'returns valid request hash' do
      @camelized_payload[:isOnlyContractId] = true
      expect(instance.issued_service_token_by_tx_hash_request(@payload)).to eq(
        @camelized_payload,
      )
    end
  end

  describe '#create_item_token_contract_request' do
    before do
      @payload = {
        service_wallet_address: 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        service_wallet_secret: 'secret',
        name: 'abc',
        base_img_uri: 'https://example.com/',
      }

      @camelized_payload = {
        serviceWalletAddress: 'tlinkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        serviceWalletSecret: 'secret',
        name: 'abc',
        baseImgUri: 'https://example.com/',
      }
    end
    it 'returns valid request hash' do
      expect(instance.create_item_token_contract_request(@payload)).to eq(
        @camelized_payload,
      )
    end

    it 'throws argument error' do
      @payload[:service_wallet_address] = nil
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end

    it 'throws argument error' do
      @payload[:service_wallet_secret] = nil
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end

    it 'throws argument error' do
      @payload[:service_wallet_address] = 'invalid'
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end

    it 'throws argument error' do
      @payload[:name] = ''
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end

    it 'throws argument error' do
      @payload[:name] = 'AAAAAAAAAAAAAAAAAAAAA'
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end

    it 'throws argument error' do
      @payload[:base_img_uri] = 'https://example.com/hoge.png'
      expect {
        instance.create_item_token_contract_request(@payload)
      }.to raise_error(ArgumentError)
    end
  end

  describe '#created_item_token_contract_request' do
    before do
      @payload = { is_only_contract_id: true }
      @camelized_payload = { isOnlyContractId: false }
    end
    it 'returns valid request hash' do
      expect(instance.created_item_token_contract_request({})).to eq(
        @camelized_payload,
      )
    end

    it 'returns valid request hash' do
      @camelized_payload[:isOnlyContractId] = true
      expect(instance.created_item_token_contract_request(@payload)).to eq(
        @camelized_payload,
      )
    end

    it 'returns valid request hash if tx_hash is set' do
      @payload[:tx_hash] = 'valid_hash'
      @camelized_payload[:txHash] = 'valid_hash'
      @camelized_payload[:isOnlyContractId] = true
      expect(instance.created_item_token_contract_request(@payload)).to eq(
        @camelized_payload,
      )
    end
  end
end
