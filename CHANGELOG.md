# Changelog

All notable changes to this project will be documented here.

## [Unreleased]

## [1.1.1] - 2026-09-30

### Security

- Every panel `Text` item, including the shared `DetailRow`, `MiniStat`, `FeeCell` and other display components, now renders with `textFormat: Text.PlainText`, so remote strings such as the mempool.space miner/pool name cannot be interpreted as rich text or load inline images.
- Added `tests/plain-text.test.sh`, which fails if any QML `Text` item omits the plain-text format.

## [1.1.0] - 2026-09-30

Forked from [nmorton13/omarchy-bitcoin-bar](https://github.com/nmorton13/omarchy-bitcoin-bar) 1.0.2 as `derekross.bitcoin`.

- Added four bar views: USD price, sats per USD, price + block height, and price + block height + next-block fee. The choice persists and can also be set in the widget settings.
- Right-click now cycles the bar view; left-click opens the summary.
- The sats label reads `SATS/USD` for US dollars, matching the other currencies.

## [1.0.2] - 2026-09-01

- Corrected the author name to Nathan Morton.

### Security

- Bounded every remote API response at the producer: all six collectors now fetch through `scripts/fetch-json.sh`, which caps bytes while receiving and rejects overflow before parsing or output, so an oversized or endless response cannot consume disk or parser memory.
- Added matching byte, item, and string caps to the `Model.js` parsers, bounding response size, sparkline and fee-range lengths, and retained strings.

## [1.0.1] - 2026-08-28

- Fixed the popup position so the Bitcoin panel anchors to its bar icon.

## [1.0.0] - 2026-08-28

- Initial Omarchy bar-widget release.
- Added Bitcoin network, fee, difficulty, mempool, and market summaries.
- Added animated left-side block and price detail panes.
- Added the 24-hour price chart and multi-fiat sats display.
- Added persistent refresh, fiat, and bar-label preferences.
- Added stale-data handling, partial updates, retries, and backoff.
