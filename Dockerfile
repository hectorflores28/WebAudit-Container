FROM nginx:alpine
RUN apk add --no-cache nikto perl

COPY ./destination-path /usr/share/nginx/html
EXPOSE 80