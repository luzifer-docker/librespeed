# Luzifer-docker / librespeed

This is a container setup for the [Go variant](https://github.com/librespeed/speedtest-go) of the [LibreSpeed speed test](https://librespeed.org/), fully configurable through environment variables and runnable out-of-the-box.

## Available configuration variables

| ENV Variable | Default Value |
| ------------ | ------------- |
| ASSETS_PATH | `/usr/local/share/speedtest` |
| BIND_ADDR |  |
| DB_FILE | `/data/speedtest.db` |
| DB_HOST |  |
| DB_NAME |  |
| DB_PASS |  |
| DB_TYPE | `bolt` |
| DB_USER |  |
| IPINFO_API_KEY |  |
| LISTEN_PORT | `8989` |
| REDACT_IP_ADDRESSES | `true` |
| SERVER_LAT | `0` |
| SERVER_LON | `0` |
| STATISTICS_PASSWORD |  |
