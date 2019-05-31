FROM node:lts as builder

RUN apt update && apt install -y openjdk-8-jre busybox

ADD . ~

RUN cd ~ && npm install && npm run build

FROM node:lts-alpine

MAINTAINER Gitai<i@gitai.me>

COPY --from=builder ~/public ~/package.json ~/server.js ~/

RUN cd ~ && npm install --production

ENTRYPOINT ["node", "/root/server.js"]
