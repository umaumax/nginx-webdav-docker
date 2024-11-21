#!/usr/bin/env bash
cat <<EOF
# Please use below command to check the url.
port=\$(docker inspect $(hostname) | jq -r '.[0].NetworkSettings.Ports["80/tcp"][0].HostPort')
echo "http://localhost:\$port/"

EOF
