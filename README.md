# LbdSdk

**Unofficial** LINE Blockchain API Client for Ruby.

- [LINE Blockchain](https://docs-blockchain.line.biz/overview/)
- [API overview](https://docs-blockchain.line.biz/api-guide/API-Reference)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lbd_sdk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lbd_sdk

## Usage

```ruby
client = LbdSdk::Client.new do |config|
  config.endpoint = 'https://test-api.blockchain.line.me/'
  config.api_key = 'your_api_key'
  config.api_secret_key = 'your_secret_key'
end

client.time()

client.user_detail("<your-user-id>")

client.user_transactions("<your-user-id>", {page: 1, limit: 1})
```

## TODO

- [x] GET /v1/services/{serviceId}
- [x] GET /v1/service-tokens/
- [x] GET /v1/service-tokens/{contractId}
- [x] PUT /v1/service-tokens/{contractId}
- [x] POST /v1/service-tokens/{contractId}/mint
- [x] POST /v1/service-tokens/{contractId}/burn-from
- [x] GET /v1/service-tokens/{contractId}/holders
- [x] GET /v1/item-tokens/{contractId}
- [x] GET /v1/item-tokens/{contractId}/fungibles
- [x] GET /v1/item-tokens/{contractId}/fungibles/{tokenType}
- [x] GET /v1/item-tokens/{contractId}/fungibles/{tokenType}/holders
- [x] GET /v1/item-tokens/{contractId}/non-fungibles
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/holders
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/holder
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/children
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/parent
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/root
- [x] GET /v1/item-tokens/{contractId}/fungibles/icon/{request-id}/status
- [x] GET /v1/item-tokens/{contractId}/non-fungibles/icon/{request-id}/status
- [x] PUT /v1/item-tokens/{contractId}/fungibles/{tokenType}
- [ ] PUT /v1/item-tokens/{contractId}/fungibles/icon
- [x] PUT /v1/item-tokens/{contractId}/non-fungibles/{tokenType}
- [x] PUT /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}
- [ ] PUT /v1/item-tokens/{contractId}/non-fungibles/icon
- [x] POST /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/parent
- [x] DELETE /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/parent
- [x] POST /v1/item-tokens/{contractId}/fungibles
- [x] POST /v1/item-tokens/{contractId}/fungibles/{tokenType}/mint
- [x] POST /v1/item-tokens/{contractId}/fungibles/{tokenType}/burn
- [ ] POST /v1/item-tokens/{contractId}/non-fungibles
- [ ] POST /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/mint
- [ ] POST /v1/item-tokens/{contractId}/non-fungibles/multi-mint
- [ ] POST /v1/item-tokens/{contractId}/non-fungibles/multi-recipients/multi-mint
- [ ] POST /v1/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/burn
- [x] GET /v1/users/{userId}
- [x] GET /v1/users/{userId}/transactions
- [x] GET /v1/users/{userId}/base-coin
- [x] GET /v1/users/{userId}/service-tokens
- [x] GET /v1/users/{userId}/service-tokens/{contractId}
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/fungibles
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/fungibles/{tokenType}
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/non-fungibles
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/non-fungibles/{tokenType}
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}
- [x] GET /v1/user-requests/{requestSessionToken}
- [x] GET /v1/users/{userId}/service-tokens/{contractId}/proxy
- [x] GET /v1/users/{userId}/item-tokens/{contractId}/proxy
- [x] POST /v1/users/{userId}/base-coin/request-transfer
- [x] POST /v1/users/{userId}/service-tokens/{contractId}/request-transfer
- [x] POST /v1/users/{userId}/service-tokens/{contractId}/request-proxy
- [x] POST /v1/users/{userId}/item-tokens/{contractId}/request-proxy
- [x] POST /v1/user-requests/{requestSessionToken}/commit
- [x] POST /v1/users/{userId}/service-tokens/{contractId}/transfer
- [x] POST /v1/users/{userId}/item-tokens/{contractId}/fungibles/{tokenType}/transfer
- [x] POST /v1/users/{userId}/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/transfer
- [x] POST /v1/users/{userId}/item-tokens/{contractId}/non-fungibles/batch-transfer
- [x] GET /v1/wallets
- [x] GET /v1/wallets/{walletAddress}
- [x] GET /v1/wallets/{walletAddress}/transactions
- [x] GET /v1/wallets/{walletAddress}/base-coin
- [x] GET /v1/wallets/{walletAddress}/service-tokens
- [x] GET /v1/wallets/{walletAddress}/service-tokens/{contractId}
- [x] GET /v1/wallets/{walletAddress}/item-tokens/{contractId}/fungibles
- [x] GET /v1/wallets/{walletAddress}/item-tokens/{contractId}/fungibles/{tokenType}
- [x] GET /v1/wallets/{walletAddress}/item-tokens/{contractId}/non-fungibles
- [x] GET /v1/wallets/{walletAddress}/item-tokens/{contractId}/non-fungibles/{tokenType}
- [x] GET /v1/wallets/{walletAddress}/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}
- [x] POST /v1/wallets/{walletAddress}/base-coin/transfer
- [x] POST /v1/wallets/{walletAddress}/service-tokens/{contractId}/transfer
- [x] POST /v1/wallets/{walletAddress}/item-tokens/{contractId}/fungibles/{tokenType}/transfer
- [x] POST /v1/wallets/{walletAddress}/item-tokens/{contractId}/non-fungibles/{tokenType}/{tokenIndex}/transfer
- [x] POST /v1/wallets/{walletAddress}/item-tokens/{contractId}/non-fungibles/batch-transfer
- [x] POST /v1/memos
- [x] GET /v1/memos/{txHash}
- [x] GET /v1/time
- [x] GET /v1/transactions/{txHash}

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lbd_sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/YuheiNakasaka/lbd_sdk_rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LbdSdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/YuheiNakasaka/lbd_sdk_rb/blob/main/CODE_OF_CONDUCT.md).
