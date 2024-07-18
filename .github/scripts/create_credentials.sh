#!/bin/bash

TOKEN_VALIDITY_SECONDS=3600
EXPIRATION_TIMESTAMP=$(($(date +%s) * 1000 + TOKEN_VALIDITY_SECONDS * 1000))

mkdir -p ~/.pub-cache
cat <<EOF > ~/.pub-cache/credentials.json
{
  "accessToken": "${OAUTH_ACCESS_TOKEN}",
  "refreshToken": "${OAUTH_REFRESH_TOKEN}",
  "tokenEndpoint": "${TOKEN_ENDPOINT}",
  "scopes": [ "openid", "${AUTH_SCOPES}" ],
  "expiration": ${EXPIRATION_TIMESTAMP}
}
EOF
