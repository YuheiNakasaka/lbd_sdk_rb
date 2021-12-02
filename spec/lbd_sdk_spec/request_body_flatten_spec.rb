# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LbdSdk::RequestBodyFlattener do
  let(:instance) do
    described_class.new
  end

  describe '#flatten' do
    context 'when request body is an empty hash' do
      it 'should return an empty string' do
        input = {}
        expected = ''
        expect(instance.flatten(input)).to eq(expected)
      end
    end

    context 'when request body is a normal hash' do
      it 'should return a parsed string' do
        input = {
          ownerAddress: 'tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq',
          ownerSecret: 'uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo=',
          name: 'NewName'
        }
        expected = 'name=NewName&ownerAddress=tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq&ownerSecret=uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo='
        expect(instance.flatten(input)).to eq(expected)
      end
    end

    context 'when request body has an array' do
      it 'should return a parsed string' do
        input = {
          ownerAddress: 'tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq',
          ownerSecret: 'uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo=',
          toAddress: 'tlink18zxqds28mmg8mwduk32csx5xt6urw93ycf8jwp',
          mintList: [
            {
              tokenType: '10000001',
              name: 'NewNFT'
            },
            {
              tokenType: '10000003',
              name: 'NewNFT2',
              meta: 'New nft 2 meta information'
            }
          ]
        }
        expected = 'mintList.meta=,New nft 2 meta information&mintList.name=NewNFT,NewNFT2&mintList.tokenType=10000001,10000003&ownerAddress=tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq&ownerSecret=uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo=&toAddress=tlink18zxqds28mmg8mwduk32csx5xt6urw93ycf8jwp'
        expect(instance.flatten(input)).to eq(expected)
      end
    end
  end
end
