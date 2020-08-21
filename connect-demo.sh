#!/usr/bin/env bash
CONNECT_CONFIG_ID=ocid1.connectharness.oc1.us-sanjose-1.amaaaaaauwpiejqakun3l2ljpdhd4kdlopuem5zfpqjkklwb35y5byspkzfa

CONFIG_STORAGE_TOPIC=$CONNECT_CONFIG_ID-config
OFFSET_STORAGE_TOPIC=$CONNECT_CONFIG_ID-offset
STATUS_STORAGE_TOPIC=$CONNECT_CONFIG_ID-status

docker build -t connect .

docker run -it --rm --name connect -p 8083:8083 \
-e GROUP_ID=connect-demo-group \
-e BOOTSTRAP_SERVERS=cell-1.streaming.us-sanjose-1.oci.oraclecloud.com:9092 \
-e CONFIG_STORAGE_TOPIC=$CONFIG_STORAGE_TOPIC \
-e OFFSET_STORAGE_TOPIC=$OFFSET_STORAGE_TOPIC \
-e STATUS_STORAGE_TOPIC=$STATUS_STORAGE_TOPIC \
-v `pwd -P`/connect-distributed.properties:/kafka/config.orig/connect-distributed.properties \
connect
