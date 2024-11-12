#!/bin/sh -euc

mkdir -p /data/loki-data
mkdir -p /data/loki-ruler

exec minio server /data