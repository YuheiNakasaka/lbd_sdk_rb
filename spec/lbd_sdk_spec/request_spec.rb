# frozen_string_literal: true

require 'spec_helper'
require 'lbd_sdk/request'

class DummyClass
  include LbdSdk::Request
end

RSpec.describe LbdSdk::Request do
  let(:instance) do
    DummyClass.new
  end

  describe '#page_request' do
    it 'returns a default hash' do
      expect(instance.page_request({})).to eq({
        limit: 10,
        page: 1,
        orderBy: 'desc',
      })
    end

    it 'should be set arbitrary params' do
      expect(instance.page_request({limit: 1, page: 2, order_by: 'asc'})).to eq({
        limit: 1,
        page: 2,
        orderBy: 'asc',
      })
    end
  end

  describe '#transaction_page_request' do
    it 'returns a default hash' do
      expect(instance.transaction_page_request({})).to eq({
        limit: 10,
        page: 1,
        orderBy: 'desc',
      })
    end

    it 'should be set arbitrary params' do
      timestamp = (Time.now.to_f * 1000).round
      expect(instance.transaction_page_request({
        limit: 1,
        page: 2,
        order_by: 'asc',
        before: timestamp,
        after: timestamp,
        msgType: 'coin/MsgSend',
      })).to eq({
        limit: 1,
        page: 2,
        orderBy: 'asc',
        before: timestamp,
        after: timestamp,
        msgType: 'coin/MsgSend',
      })
    end
  end
end