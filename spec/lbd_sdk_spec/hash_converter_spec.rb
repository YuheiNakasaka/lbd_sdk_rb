# frozen_string_literal: true

require 'spec_helper'
require 'lbd_sdk/hash_converter'

class DummyClass
  include LbdSdk::HashConverter
end

RSpec.describe LbdSdk::HashConverter do
  let(:instance) { DummyClass.new }

  describe '#camelize' do
    it 'returns camelized hash' do
      expect(instance.camelize({ abc: 1 })).to eq({ abc: 1 })
    end

    it 'returns camelized hash' do
      expect(instance.camelize({ a_b: 1 })).to eq({ aB: 1 })
    end

    it 'returns camelized hash' do
      expect(instance.camelize({ a_b: 1, cd_ef_gh: 2 })).to eq(
        { aB: 1, cdEfGh: 2 },
      )
    end

    it 'returns camelized hash' do
      expect(instance.camelize({ a_b: { nested_key: 1 } })).to eq(
        { aB: { nestedKey: 1 } },
      )
    end

    it 'returns empty hash' do
      expect(instance.camelize({})).to eq({})
    end
  end
end
