FROM node:10.19.0-alpine3.10 as builder

WORKDIR /ui

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

COPY . .

#ENV NODE_ENV $NODE_ENV
RUN npm install -g @angular/cli@v1.4.3 && \
    npm run build:allelements

RUN ls -la dist 
RUN ls -la


FROM nginx:alpine as production-build
COPY --from=builder /ui/nginx.conf /etc/nginx/conf.d/default.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy from the stahg 1
COPY --from=builder /ui/dist /usr/share/nginx/html
COPY --from=builder /ui/dist/headerApp/*.js /usr/share/nginx/html/
RUN ls -la /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
