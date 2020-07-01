#!/bin/bash

docker build --no-cache --pull -t ide:1.0 .
docker run -P --name ide -it ide:1.0 bash
