Go About Nginx SSL terminator Docker image
==========================================

An Nginx container that provides SSL termination for linked containers.

## Usage

This container uses structured template variables that cannot be expressed in
environment variables. You need a YAML file for the configuration:

    cat > variables.yml <<'.'
    ---
    ssl:
      certificate: |
        -----BEGIN CERTIFICATE-----
        [...]
        -----END CERTIFICATE-----
      certificate_key: |
        -----BEGIN CERTIFICATE-----
        [...]
        -----END CERTIFICATE-----
    containers:
    - name: website
      domain: example.com
      aliases:
      - www.example.com
    - name: api
      domain: api.example.com
    .

    docker run -v $PWD/variables.yml:/variables.yml goabout/nginx-sslterm
