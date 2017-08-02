#!/usr/bin/env bash

IPADDR=${1}
JAIL=${2}
FAILURES=${3}
CFTOKEN=${4}
CFUSER=${5}
CFZONE=${6}
CFMODE=${7}

curl -X POST "https://api.cloudflare.com/client/v4/zones/$CFZONE/firewall/access
_rules/rules" \
     -H "X-Auth-Email: $CFUSER" \
     -H "X-Auth-Key: $CFTOKEN" \
     -H "Content-Type: application/json" \
     --data "{\"mode\":\"$CFMODE\",\"configuration\":{\"target\":\"ip\",\"value\
":\"$IPADDR\"},\"notes\":\"$JAIL\"}"
