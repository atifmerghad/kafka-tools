# kafka-tools
  <img src="https://github.com/atifmerghad/atifmerghad/raw/master/Badges/dev/tools/bash.svg" alt="Bash" style="vertical-align:top; margin:4px">

This script will help you to perform basic tasks in Kafka without copying/pasting every time.
1. List of topics
2. Create a topic
3. Delete a topic
4. Produce data to a topic
5. Consume data from a topic
6. Describe a topic
7. Describe ACL

```
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
     'ACL')
        echo -n " - ACL > PLEASE ENTER A TOPIC NAME : "
        read topic_name
        $CONFLUENT_HOME/bin/bin/kafka-acls --bootstrap-server $BOOTSTRAP_SERVER --command-config $KAFKA_PROPERTIES --list --topic $topic_name
        ;;   
    *)
        echo "PLEASE ENTER A VALID OPERATION !"
        ;;
esac

echo -e "[=================================================================]"
```

Configuration file (Please change values based on your security mechanism) :
<ul>
  <li>--consumer.config</li>
  <li>--command-config</li>
  <li>--producer.config</li>
</ul>

```
security.protocol=SASL_SSL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="admin" password="password";
ssl.endpoint.identification.algorithm=https
sasl.mechanism=PLAIN
```

## Run script 

> `chmod +x kafka-tools.sh`   
> `./kafka-tools.sh`

