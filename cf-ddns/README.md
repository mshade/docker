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

You can also use `flarectl` interactively via shell:
```
$ docker run -it --rm mshade/flarectl /bin/ash
/ # flarectl
NAME:
   flarectl - Cloudflare CLI

USAGE:
   flarectl [global options] command [command options] [arguments...]

VERSION:
   2017.10.0

COMMANDS:
   ips, i           Print Cloudflare IP ranges
   user, u          User information
   zone, z          Zone information
   dns, d           DNS records
   user-agents, ua  User-Agent blocking
   pagerules, p     Page Rules
   railgun, r       Railgun information
   firewall, f      Firewall
   help, h          Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --account-id value  Optional account ID [$CF_ACCOUNT_ID]
   --json              show output as JSON instead of as a table
   --help, -h          show help
   --version, -v       print the version
```
