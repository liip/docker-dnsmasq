# Dnsmasq

Dnsmasq docker container image.

## Environment Variables

| Variable | Default Value
| --- | ---
| **Server**
| `DNSMASQ_DEFAULT_DOMAIN` | `localhost`
| `DNSMASQ_DNS_SERVER_1` | `1.1.1.1`
| `DNSMASQ_DNS_SERVER_2` | `1.0.0.1`

## Usage example

Here is a `docker-compose.yml` file that runs a local DNS server forwarding a default domain to local.
Please adapt it according to your needs.

```yaml
version: '3.5'
services:

  dnsmasq:
    image: liip/dnsmasq:1.0.0
    restart: always
    environment:
      DNSMASQ_DEFAULT_DOMAIN: example.test
    logging:
      options:
        max-size: 20m
    ports:
      - '53:5353/udp'
```

Additional configuration files can be mounted in `/etc/dnsmasq.d/` and will be loaded automatically.
