#!/usr/bin/env bash
set -e

# Required settings from ENV
settings=( CF_API_EMAIL CF_API_KEY ID IP_URL RECORD ZONE )

for setting in "${settings[@]}"
do
  test -z ${!setting} && echo "${setting} must be set in ENV." && FAIL=1
done

# One or more settings not configured
[ "$FAIL" == 1 ] && exit 1


IP=$(curl -s "${IP_URL}")

if [ -n $IP ]; then
  flarectl dns u --zone ${ZONE} --name ${RECORD} --id ${ID} --content ${IP}
  echo "${RECORD} updated to ${IP}."
else
  echo "Failed to obtain external IP. Check the IP_URL setting (currently: ${IP_URL})"
fi

