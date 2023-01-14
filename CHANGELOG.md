# 0.1.7(2023-01-14)

## Fix request options

- Modity `msgType` option in `transaction_page_request` to `msg_type` to unify all options format.

# 0.1.6(2023-01-11)

## Add new endpoints

- Add `GET /v2/users/{userId}/transactions`
- Add `GET /v2/wallets/{walletAddress}/transactions`
- Add `GET /v2/transactions/{txHash}`

## Deprecate endpoints

- Add warning to `GET /v1/users/{userId}/transactions`
- Add warning to `GET /v1/wallets/{walletAddress}/transactions`
- Add warning to `GET /v1/transactions/{txHash}`

# 0.1.5(2022-10-12)

- Fix invalid validation to some parametars.

# 0.1.4(2022-07-02)

## Add new endpoints

- Add `GET /v1/item-tokens/{contractId}/fungibles/thumbnails/{request-id}/status`
- Add `PUT /v1/item-tokens/{contractId}/fungibles/thumbnails`
- Add `GET /v1/item-tokens/{contractId}/fungibles/media-resources/{request-id}/status`
- Add `PUT /v1/item-tokens/{contractId}/fungibles/media-resources`
- Add `GET /v1/item-tokens/{contractId}/non-fungibles/thumbnails/{request-id}/status`
- Add `PUT /v1/item-tokens/{contractId}/non-fungibles/thumbnails`
- Add `GET /v1/item-tokens/{contractId}/non-fungibles/media-resources/{request-id}/status`
- Add `PUT /v1/item-tokens/{contractId}/non-fungibles/media-resources`

## Delete deprecated endpoints

- Delete `GET /v1/item-tokens/{contractId}/fungibles/icon/{request-id}/status`
- Delete `PUT /v1/item-tokens/{contractId}/fungibles/icon`
- Delete `GET /v1/item-tokens/{contractId}/non-fungibles/icon/{request-id}/status`
- Delete `PUT /v1/item-tokens/{contractId}/non-fungibles/icon`

# 0.1.3(2022-03-23)

- Add `GET /v1/item-tokens`.
- Add `POST /v1/item-tokens`.
- Add `GET /v1/service-tokens/by-txHash/{txHash}`.
- Add `POST /v1/service-tokens`.

# 0.1.2(2021-12-22)

- Add `GET /v1/users/{userId}/item-tokens/{contractId}/non-fungibles/with-type`.

# 0.1.1(2021-12-04)

- Refactor payload handling.

# 0.1.0(2021-12-03)

- Implemented all LINE Blockchain Developer API client.
