FROM node:10.19.0-alpine3.10

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

#ENV NODE_ENV $NODE_ENV

COPY . .

RUN npm install && \
    npm install -g @angular/cli@v1.4.3 && \
    npm run build:allelements

EXPOSE 4200

CMD npm start
