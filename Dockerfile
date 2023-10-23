FROM nginx:latest

RUN usermod -aG docker jenkins

COPY ./index-blue.html /usr/share/nginx/html/index.html

EXPOSE 80
