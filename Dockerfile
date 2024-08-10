FROM nginx:latest

RUN rm -rf /usr/share/nginx/html/*
COPY /dist/angular-app/browser/ /usr/share/nginx/html
