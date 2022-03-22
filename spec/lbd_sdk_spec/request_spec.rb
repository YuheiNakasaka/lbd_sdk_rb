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
            msgType: 'coin/MsgSend',
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
end
