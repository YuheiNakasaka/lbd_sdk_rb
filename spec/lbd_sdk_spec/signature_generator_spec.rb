# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LbdSdk::SignatureGenerator do
  let(:instance) { described_class.new }

  # LbdSdk::SignatureGenerator#generate meets below official examples at least.
  # https://docs-blockchain.line.biz/ja/api-guide/Signature-Examples
  describe '#generate' do
    context 'when query params and request body are empty' do
      it 'should return valid signature' do
        secret = '9256bf8a-2b86-42fe-b3e0-d3079d0141fe'
        method = 'GET'
        path = '/v1/wallets'
        timestamp = 1_581_850_266_351
        nonce = 'Bp0IqgXE'
        expected =
          '2LtyRNI16y/5/RdoTB65sfLkO0OSJ4pCuz2+ar0npkRbk1/dqq1fbt1FZo7fueQl1umKWWlBGu/53KD2cptcCA=='
        expect(
          instance.generate(
            secret: secret,
            method: method,
            endpoint_path: path,
            timestamp: timestamp,
            nonce: nonce,
          ),
        ).to eq(expected)
      end
    end

    context 'when only request body is empty' do
      it 'should return valid signature' do
        secret = '9256bf8a-2b86-42fe-b3e0-d3079d0141fe'
        method = 'GET'
        path =
          '/v1/wallets/tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq/transactions'
        timestamp = 1_581_850_266_351
        nonce = 'Bp0IqgXE'
        query_params = { page: 2, msgType: 'coin/MsgSend' }
        expected =
          'fasfnqKVVClFam+Dov+YN+rUfOo/PMZfgKx8E36YBtPh7gB2C+YJv4Hxl0Ey3g8lGD0ErEGnD0gqAt85iEhklQ=='
        expect(
          instance.generate(
            secret: secret,
            method: method,
            endpoint_path: path,
            timestamp: timestamp,
            nonce: nonce,
            query_params: query_params,
          ),
        ).to eq(expected)
      end
    end

    context 'when only request params is empty' do
      it 'should return valid signature' do
        secret = '9256bf8a-2b86-42fe-b3e0-d3079d0141fe'
        method = 'PUT'
        path = '/v1/item-tokens/61e14383/non-fungibles/10000001/00000001'
        timestamp = 1_581_850_266_351
        nonce = 'Bp0IqgXE'
        body = {
          ownerAddress: 'tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq',
          ownerSecret: 'uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo=',
          name: 'NewName',
        }
        expected =
          '4L5BU0Ml/ejhzTg6Du12BDdElv8zoE7XD/iyOaZ2BHJIJG0SUOuCZWXu0YaF4i4C2CFJhjZoJFsje4CJn/wyyw=='
        expect(
          instance.generate(
            secret: secret,
            method: method,
            endpoint_path: path,
            timestamp: timestamp,
            nonce: nonce,
            body: body,
          ),
        ).to eq(expected)
      end
    end

    context 'when only request params is empty and request body has nested values.' do
      it 'should return valid signature' do
        secret = '9256bf8a-2b86-42fe-b3e0-d3079d0141fe'
        method = 'POST'
        path = '/v1/item-tokens/61e14383/non-fungibles/multi-mint'
        timestamp = 1_581_850_266_351
        nonce = 'Bp0IqgXE'
        body = {
          ownerAddress: 'tlink1fr9mpexk5yq3hu6jc0npajfsa0x7tl427fuveq',
          ownerSecret: 'uhbdnNvIqQFnnIFDDG8EuVxtqkwsLtDR/owKInQIYmo=',
          toAddress: 'tlink18zxqds28mmg8mwduk32csx5xt6urw93ycf8jwp',
          mintList: [
            { tokenType: '10000001', name: 'NewNFT' },
            {
              tokenType: '10000003',
              name: 'NewNFT2',
              meta: 'New nft 2 meta information',
            },
          ],
        }
        expected =
          'vhr5c3y2PAP5rmt+4YN1ojbMnT9IkYnIIB1yvWYM9OdECB2Y11fGTLDLRybB3lLKv0kvJQMAelSkQYBKdhSXbg=='
        expect(
          instance.generate(
            secret: secret,
            method: method,
            endpoint_path: path,
            timestamp: timestamp,
            nonce: nonce,
            body: body,
          ),
        ).to eq(expected)
      end
    end
  end
end
