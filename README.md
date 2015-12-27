Go About Nginx SSL terminator Docker image
==========================================

Docker image that uses [docker-gen](https://github.com/jwilder/docker-gen)
to create and maintain a Nginx configuration for SSL termination. it is based
on [nginx-proxy](https://github.com/jwilder/nginx-proxy).


## Usage

    cat > variables.yml <<'.'
    ---
    ssl_certificate: |
      -----BEGIN CERTIFICATE-----
      [...]
      -----END CERTIFICATE-----
    ssl_certificate_key: |
      -----BEGIN PRIVATE KEY-----
      [...]
      -----END PRIVATE KEY-----
    sslterm_container: sslterm
    .

    docker run --name=sslterm \
               -p 80:80 -p 443:443 \
               -v $PWD/variables.yml:/variables.yml:ro \
               -v /run/docker.sock:/run/docker.sock:ro \
               goabout/nginx-sslterm

    docker run --name=website1 \
               -v /some/content:/usr/share/nginx/html:ro \
               -e WEB_DOMAIN=website1.example.com \
               nginx

    docker run --name=website2 \
               -v /some/content:/usr/share/nginx/html:ro \
               -e WEB_DOMAIN=website2.example.com \
               -e WEB_ALIAS=website3.example.com \
               nginx


## Variables

The image uses
[jcassee/parameterized-entrypoint](https://github.com/jcassee/parameterized-entrypoint)
for parameterization. The following variables are available:

* **ssl_certificate**: The SSL certificate (or certificate chain), in PEM
                       format.
* **ssl_certificate_key**: The private key to the SSL certificate, in PEM
                           format.

* **proxies / proxy**: Optional downstream proxies that use the PROXY protocol.
                       The latter value overrides the former. (This enables the
                       `proxy_protocol` option on all servers, which means you
                       cannot connect using plain HTTP(S) anymore.)

Containers that want to use SSL set the `WEB_DOMAIN` environment variable to
the domain (or comma-separated list of domains). Set the `WEB_ALIAS` variable
to alias(es) that should be redirected to the (first) domain.

Currently, only one SSL certificate can be used. Using per-domain certificates
(possible using [Let's Encrypt](https://letsencrypt.org/)) are on the roadmap.
