#!/bin/bash
pushd /root
wget https://s3.amazonaws.com/sigmoidanalytics-data/spork-streaming.tar
tar -xvf spork-streaming.tar
rm spork-streaming.tar
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
export SPORK_STREAMING_HOME=/root/spork-streaming
cd
export SPORK_STREAMING_HOME=/root/spork-streaming
echo "Downloading Kafka"
wget https://archive.apache.org/dist/kafka/0.8.0/kafka_2.8.0-0.8.0.tar.gz
tar -xzf kafka_2.8.0-0.8.0.tar.gz
mv kafka_2.8.0-0.8.0 kafka
echo "Downloading Redis"
wget http://download.redis.io/releases/redis-2.8.17.tar.gz
tar -xzf redis-2.8.17.tar.gz
echo "Setting up Redis"
mv redis-2.8.17 redis
cd /root/redis
make
cd
echo "Installing npm"
wget http://nodejs.org/dist/v0.10.4/node-v0.10.4.tar.gz
tar -xzf node-v0.10.4.tar.gz
cd node-v0.10.4
./configure
make
make install
echo "Installing Redis Commandar"
npm install -g redis-commander
echo "Setting up Kafka and zookeeper"
cd /root/kafka/
screen -S zookeeper -d -m bin/zookeeper-server-start.sh config/zookeeper.properties
screen -S kafka -d -m bin/kafka-server-start.sh config/server.properties
cd
echo "Done!!"

