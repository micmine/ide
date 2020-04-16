#!/bin/bash

docker build -t ide:1.0 .
docker run -it ide:1.0 bash
