#!/usr/bin/env bash

IPADDR=${1}
JAIL=${2}
CFTOKEN=${3}
CFUSER=${4}
CFZONE=${5}

JSON=$(curl -sX GET "https://api.cloudflare.com/client/v4/zones/$CFZONE/firewall/access_rules/rules?match=all&scope_typ
e=zone&configuration_value=$IPADDR&notes=$JAIL" \
     -H "X-Auth-Email: $CFUSER" \
     -H "X-Auth-Key: $CFTOKEN" \
     -H "Content-Type: application/json")
IDENTIFIER=$(echo $JSON | jq -r '.result[0].id')

if [ "$IDENTIFIER" == "null" ]; then
	echo "No rule found for this IP"
	exit 1
else
	RESULT=$(curl -sX DELETE "https://api.cloudflare.com/client/v4/zones/$CFZONE/firewall/access_rules/rules/$IDENT
IFIER" \
		-H "X-Auth-Email: $CFUSER" \
		-H "X-Auth-Key: $CFTOKEN" \
		-H "Content-Type: application/json" \
		--data '{"cascade":"none"}')
	SUCCESS=$(echo $RESULT | jq '.success')
	echo "Unbanned: $SUCCESS"
	exit 0
fi
