FROM node:lts-alpine3.17
LABEL org.opencontainers.image.source="https://github.com/Nikki18977/00_gate"

WORKDIR /app

COPY app/ .

ARG HMAC_ALGO='sha256'
ARG HMAC_SECRET='secret'

ENV HMAC_ALGO=${HMAC_ALGO}
ENV HMAC_SECRET=${HMAC_SECRET}
ENV NODE_ENV=production

RUN yarn install 

USER node

ENTRYPOINT [ "/bin/sh", "-c", "yarn run startdev" ]

EXPOSE 9000