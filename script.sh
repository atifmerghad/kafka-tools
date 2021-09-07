#!/bin/bash

CONFLUENT_HOME=/home/user/confluent
BOOTSTRAP_SERVER=b-1.host-name.kafka.us-west-2.amazonaws.com:9096,b-2.host-name.kafka.us-west-2.amazonaws.com:9096,b-3.host-name.kafka.us-west-2.amazonaws.com:9096
KAFKA_PROPERTIES=kafka.properties
echo -e "[====================  KAFKA QUICK TOOLS  =====================]"
echo -n " * OPERATIONS [CREATE, LIST , DELETE, PRODUCE, CONSUME] : "
read operation
case $operation in
    'LIST')
        $CONFLUENT_HOME/bin/kafka-topics --list --bootstrap-server $BOOTSTRAP_SERVER  --command-config $KAFKA_PROPERTIES
        ;;
    'CREATE')
        echo -n " - CREATE > PLEASE ENTER A TOPIC NAME : "
        read topic_name
       $CONFLUENT_HOME/bin/kafka-topics --create --bootstrap-server $BOOTSTRAP_SERVER --command-config $KAFKA_PROPERTIES --topic $topic_name
        ;;
    'DELETE')
        echo -n " - DELETE > PLEASE ENTER A TOPIC NAME : "
        read topic_name
        $CONFLUENT_HOME/bin/kafka-topics  --bootstrap-server $BOOTSTRAP_SERVER --command-config   $KAFKA_PROPERTIES   --delete --topic $topic_name
        ;;
    'PRODUCE')
        echo -n " - PRODUCE > PLEASE ENTER A TOPIC NAME : "
        read topic_name
        $CONFLUENT_HOME/bin/kafka-console-producer --broker-list $BOOTSTRAP_SERVER --producer.config  $KAFKA_PROPERTIES  --topic $topic_name
        ;;
    'CONSUME')
        echo -n " - CONSUME > PLEASE ENTER A TOPIC NAME : "
        read topic_name
        $CONFLUENT_HOME/bin/kafka-console-consumer  -bootstrap-server $BOOTSTRAP_SERVER --consumer.config $KAFKA_PROPERTIES --topic $topic_name
        ;;
    'DESCRIBE')
        echo -n " - DESCRIBE > PLEASE ENTER A TOPIC NAME : "
        read topic_name
        $CONFLUENT_HOME/bin/kafka-topics --describe --bootstrap-server $BOOTSTRAP_SERVER --command-config $KAFKA_PROPERTIES --topic $topic_name
        ;;        
    *)
        echo "PLEASE ENTER A VALID OPERATION !"
        ;;
esac

echo -e "[=================================================================]"
