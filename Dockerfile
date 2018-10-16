FROM node:10.7-alpine as build-env
WORKDIR /app
COPY . /app
RUN npm install -g yarn
RUN yarn 
RUN yarn report && cp report.html /tmp/index.html

FROM openresty/openresty:alpine
COPY nginx.conf usr/local/openresty/nginx/conf/
COPY --from=build-env /tmp/index.html /usr/local/openresty/nginx/html/index.html
COPY --from=build-env /app/app.html /usr/local/openresty/nginx/html/app.html
EXPOSE 80
EXPOSE 443