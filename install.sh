#!/bin/bash

echo "STEP [1/4]"
cd application && npm install

echo "STEP [2/4]"
npm run build

echo "STEP [3/4]"
docker-compose build

echo "STEP [4/4]"
docker-compose up -d

docker logs nest-app-nginx -f