#!/bin/sh
# Point an A record at this network's public IP, as Cloudflare itself sees it.
set -eu
: "${CF_API_TOKEN:?must be set (Zone:Read + DNS:Edit on the zone)}"
: "${ZONE:?must be set, e.g. example.com}"
: "${RECORD:?must be set, e.g. home.example.com}"

api=https://api.cloudflare.com/client/v4
cf() { curl -sS --fail-with-body -H "Authorization: Bearer $CF_API_TOKEN" -H 'Content-Type: application/json' "$@"; }

ip=$(curl -sS --fail https://1.1.1.1/cdn-cgi/trace | sed -n 's/^ip=//p')
echo "$ip" | grep -Eq '^([0-9]{1,3}\.){3}[0-9]{1,3}$' || { echo "no IPv4 from Cloudflare trace (got '$ip')" >&2; exit 1; }

zone_id=$(cf "$api/zones?name=$ZONE" | jq -r '.result[0].id // empty')
[ -n "$zone_id" ] || { echo "zone $ZONE not found (or token can't read it)" >&2; exit 1; }
record=$(cf "$api/zones/$zone_id/dns_records?type=A&name=$RECORD" | jq -c '.result[0] // empty')
[ -n "$record" ] || { echo "A record $RECORD not found in $ZONE" >&2; exit 1; }

current=$(echo "$record" | jq -r .content)
if [ "$current" = "$ip" ]; then
  echo "$RECORD already $ip"
  exit 0
fi
cf -X PATCH "$api/zones/$zone_id/dns_records/$(echo "$record" | jq -r .id)" --data "{\"content\":\"$ip\"}" >/dev/null
echo "$RECORD updated $current -> $ip"
