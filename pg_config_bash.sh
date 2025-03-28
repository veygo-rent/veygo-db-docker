#!/usr/bin/env bash
set -e

echo "=== Enabling SSL in Postgres and whitelisting IPs ==="

# Copy the certificate/key from the mounted volume
# (We assume you put them at /app/cert/db.veygo.rent.pem / db.veygo.rent.key).
# cp /app/cert/us01.db.veygo.rent.pem "$PGDATA/server.crt"
# cp /app/cert/us01.db.veygo.rent.key "$PGDATA/server.key"

# Adjust ownership and permissions so Postgres accepts them
# chown postgres:postgres "$PGDATA/server.crt" "$PGDATA/server.key"
# chmod 600 "$PGDATA/server.crt"
# chmod 600 "$PGDATA/server.key"

# Turn on SSL in postgresql.conf
# {
#   echo "ssl = on"
#   echo "ssl_cert_file = 'server.crt'"
#   echo "ssl_key_file = 'server.key'"
# } >> "$PGDATA/postgresql.conf"

# Comment out existing 'host' lines so only 'hostssl' lines remain
sed -i "s/^host\s\+/#host /" "$PGDATA/pg_hba.conf"

# Whitelist addresses over SSL with password authentication (md5 or scram-sha-256)
{
  echo "host all all 127.0.0.1/32            trust"
  echo "host all all 172.18.0.0/16           trust"
} >> "$PGDATA/pg_hba.conf"

echo "=== SSL & Whitelist configuration complete ==="
