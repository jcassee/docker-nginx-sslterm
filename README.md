Go About Nginx SSL terminator Docker image
==========================================

An Nginx container that provides SSL termination for linked containers.

## Usage

    cat > variables.yml <<'.'
    ---
    ssl:
      certificate: |
        -----BEGIN CERTIFICATE-----
        [...]
        -----END CERTIFICATE-----
      certificate_key: |
        -----BEGIN PRIVATE KEY-----
        [...]
        -----END PRIVATE KEY-----
    proxies:
    - server: website
      domain: example.com
      aliases:
      - www.example.com
      - new.example.com
    - server: api
      domain: api.example.com
    .

    docker run -v $PWD/variables.yml:/variables.yml goabout/nginx-sslterm


## Variables

The images uses
[jcassee/parameterized-entrypoint](https://github.com/jcassee/parameterized-entrypoint)
for parameterization. The following variables are available:

* **ssl**: SSL configuration:
    * **certificate**: The SSL certificate (or certificate chain), in PEM
                       format.
    * **certificate_key**: The private key to the SSL certificate, in PEM
                           format.

* **proxies**: Website proxies:
    * **domain / domains**: The canonical domain name(s). The latter value
                          overrides the former.
    * **alias / aliases**: Domain alias(es) that will be redirected to the
                           (first) canonical domain. The latter value overrides
                           the former.

Because the container uses structured template variables that cannot be expressed in environment variables you need to use a YAML file.
