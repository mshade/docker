# cf-ddns
Dynamic DNS for Cloudflare: points an existing A record at the public IP of the network it runs in.

The IP comes from Cloudflare's own `https://1.1.1.1/cdn-cgi/trace` (the address Cloudflare sees you
connect from), so no third-party IP service is trusted. The record is only updated when it differs.

Configure with environment variables:

```
CF_API_TOKEN=xxxxx         # API token with Zone:Read + DNS:Edit on the zone
ZONE=example.com           # the zone
RECORD=home.example.com    # an existing A record in it
```

```
docker run --rm --env-file .env mshade/cf-ddns
```

Exits non-zero (so a CronJob/Job shows it failed) if the IP can't be determined, the zone or record
isn't found, or the API call fails.
