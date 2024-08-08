# start zookeepper( binding to port 0.0.0.0/0.0.0.0:2181 )
sudo ./kafka_/bin/zookeeper-server-start.sh ./kafka_/config/zookeeper.properties
# start kafka broker 0
sudo ./kafka_/bin/kafka-server-start.sh ./kafka_/config/server.properties
# start kafka broker 1
sudo ./kafka_/bin/kafka-server-start.sh ./kafka_/config/server-1.properties
# start kafka broker 2
sudo ./kafka_/bin/kafka-server-start.sh ./kafka_/config/server-2.properties

#------------------Kafka with Kraft--------------------------------

#Generate a Cluster UUID
KAFKA_CLUSTER_ID="$(./kafka_/bin/kafka-storage.sh random-uuid)"

#Format Log Directories
./kafka_/bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c ./kafka_/config/kraft/server.properties

#Start the Kafka Server
./kafka_/bin/kafka-server-start.sh ./kafka_/config/kraft/server.properties
#----------------------------------------------------------------------


# create topic (3 broker, 1 partition, bootstraper server location)

# The replication factor is provided by doing  --replication-factorand this represents how many copies of the event you want kafka to store in case one of the brokers goes down.

# The partitions is a mechanism to allow consuming application to scale, if you want two consumers to work together, you need two partitions.

sudo ./kafka_/bin/kafka-topics.sh --create --topic mytp --replication-factor 3 --bootstrap-server localhost:9092

# check topic
sudo ./kafka_/bin/kafka-topics.sh --list --bootstrap-server localhost:9092

# describe topic
sudo ./kafka_/bin/kafka-topics.sh --describe --topic mytp --bootstrap-server localhost:9092

Topic: mytp	TopicId: KUtprQ9SRXm6C4cZOrHUow	PartitionCount: 1	ReplicationFactor: 3	Configs: 
	Topic: mytp	Partition: 0	Leader: 0	Replicas: 0,2,1	Isr: 0,2,1

#producer
sudo ./kafka_/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic mytp

# Consumer
sudo ./kafka_/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mytp --from-beginning


#Add connect file jar to path
echo "plugin.path=./kafka_/libs/connect-file-3.4.0.jar" >> ./kafka_/config/connect-standalone.properties
#start by creating some seed data to test with:
echo -e "foo\nbar" > test.txt
#start two connectors running in standalone mode
./kafka_/bin/connect-standalone.sh ./kafka_/config/connect-standalone.properties ./kafka_/config/connect-file-source.properties ./kafka_/config/connect-file-sink.properties
##the data is being stored in the Kafka topic connect-test, so we can also run a console consumer to see the data in the topic
./kafka_/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic connect-test --from-beginning

#TERMINATE THE KAFKA ENVIRONMENT
- Stop producer, consumer
- Stop brokers
- Stop zookeeper
- Remove topics and configurations
rm -rf /tmp/kafka-logs /tmp/zookeeper /tmp/kraft-combined-logs


# Kurbenetes Stateful sets
# Ordered, graceful deployment, scaling and automated rolling updates
  - unique identity
  - persistent storage
  - Smooth updates

sudo kubectl apply -f statefulset-kafka.yml