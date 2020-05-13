# cf-ddns
Dynamic DNS utility using cloudflare's flarectl.

Provide the required config by environment variables, and running the container will update the given record with the IP fetched.

`.env` example:

```
CF_API_EMAIL=derp@example.com
CF_API_KEY=xxxxx # obtain from CF

ID=xxxxxxx # record ID

IP_URL=http://icanhazip.com/ # An IP provider of your choice, must return single line with just the IP

RECORD=subdomain.example.com # The record to update
ZONE=example.com # the parent zone
```

