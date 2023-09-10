FROM nginx:latest

COPY ./Nginx/nginx.conf /etc/nginx/nginx.conf.template
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]