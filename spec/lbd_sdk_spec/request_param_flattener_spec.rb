# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LbdSdk::RequestParamFlattener do
  let(:instance) do
    described_class.new
  end

  describe '#flatten' do
    context 'when query params are an empty hash' do
      it 'should return an empty string' do
        input = {}
        expected = ''
        expect(instance.flatten(input)).to eq(expected)
      end
    end

    context 'when query params are a normal hash' do
      it 'should return a parsed string' do
        input = {
          page: 2,
          msgType: 'coin/MsgSend'
        }
        expected = 'page=2&msgType=coin/MsgSend'
        expect(instance.flatten(input)).to eq(expected)
      end
    end
  end
end
