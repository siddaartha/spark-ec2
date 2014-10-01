#!/bin/bash
pushd /root
wget https://s3.amazonaws.com/sigmoidanalytics-data/spork-streaming.tar.gz
tar -xzf spork-streaming.tar.gz
rm spork-streaming.tar.gz
cd spork-streaming
echo "In spork-streaming"
yum install ant -y
ant jar-all
pushd /root/spork-streaming
cp modified_jars/spark-streaming_2.10-0.9.0-incubating.jar ./build/ivy/lib/Pig/
rm ivy.xml
cp /root/ivy.xml /root/spork-streaming/
cd /root/spork-streaming
ant jar-all
cd /root/spork-streaming
export SPARK_HOME=/root/spark
export HADOOP_HOME=/root/ephemeral-hdfs
export HADOOP_CONF_DIR=$HADOOP_HOME/conf
#export SPARK_MASTER="set spark master here"
sleep 3
cd
echo "Downloading Kafka"
wget https://archive.apache.org/dist/kafka/0.8.0/kafka_2.8.0-0.8.0.tar.gz
tar -xzf kafka_2.8.0-0.8.0.tar.gz
echo "Downloading Redis"
wget http://download.redis.io/releases/redis-2.8.17.tar.gz
tar -xzf redis-2.8.17.tar.gz
echo "Done!!"

