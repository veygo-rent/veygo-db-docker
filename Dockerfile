# Start from the official Postgres image
FROM postgres:latest

# Install openssl for random password generation
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Copy our init script that will configure SSL and pg_hba.conf
COPY pg_config_bash.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/pg_config_bash.sh

EXPOSE 5432
