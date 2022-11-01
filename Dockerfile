FROM ubuntu:latest
ENV NODE_VERSION=16.13.0

WORKDIR /app

COPY application/dist .
COPY application/package-lock.json .
COPY application/package.json .

RUN apt-get update

RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

ENV NVM_DIR=/root/.nvm

RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

COPY application/dist .
COPY application/package-lock.json .
COPY application/package.json .

RUN npm install

CMD [ "node", "/app/main.js" ]