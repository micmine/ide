#!/bin/bash

docker build -t ide:1.0 .
docker run -P -it ide:1.0 bash
