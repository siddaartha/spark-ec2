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

