FROM goabout/nginx

MAINTAINER Go About <tech@goabout.com>

COPY ssl_certificate.pem /templates/etc/nginx/ssl_certificate.pem
COPY ssl_certificate_key.pem /templates/etc/nginx/ssl_certificate_key.pem

COPY nginx.conf /templates/etc/nginx/sites-enabled/ssl-terminator
