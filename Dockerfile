FROM nginx:latest

COPY ./index-green.html /usr/share/nginx/html/index.html

EXPOSE 80
