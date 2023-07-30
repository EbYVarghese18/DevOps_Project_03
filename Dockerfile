FROM nginx:latest

COPY ./index-blue.html /usr/share/nginx/html/index.html

EXPOSE 80
