#!/bin/bash
set -euo pipefail

config_file="/etc/speedtest/settings.toml"
rand_pass=$(head -c 50 /dev/urandom | sha1sum | cut -d ' ' -f 1)

if [ -f "${config_file}" ]; then
	echo "Found configuration in ${config_file}, ENV is not used"
else
	[[ -n ${STATISTICS_PASSWORD:-} ]] || {
		STATISTICS_PASSWORD=${rand_pass}
		echo "/!\\ For security reasons random statistics password has been set: ${rand_pass}"
	}

	cat -s <<EOF >${config_file}
# bind address, use empty string to bind to all interfaces
bind_address="${BIND_ADDR:-}"
# backend listen port
listen_port=${LISTEN_PORT:-8989}
# Server location
server_lat=${SERVER_LAT:-0}
server_lng=${SERVER_LON:-0}
# ipinfo.io API key, if applicable
ipinfo_api_key="${IPINFO_API_KEY:-}"

# assets directory path, defaults to \$(assets) in the same directory
assets_path="${ASSETS_PATH:-/usr/local/share/speedtest}"

# password for logging into statistics page
statistics_password="${STATISTICS_PASSWORD}"
# redact IP addresses
redact_ip_addresses=${REDACT_IP_ADDRESSES:-true}

# database type for statistics data, currently supports: bolt, mysql, postgresql
database_type="${DB_TYPE:-bolt}"
database_hostname="${DB_HOST:-}"
database_name="${DB_NAME:-}"
database_username="${DB_USER:-}"
database_password="${DB_PASS:-}"

# if you use \$(bolt) as database, set database_file to database file location
database_file="${DB_FILE:-/data/speedtest.db}"
EOF

fi

exec /usr/local/bin/speedtest
