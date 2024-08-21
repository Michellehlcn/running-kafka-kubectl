# Running in Kubernetes (using a Helm Chart)
# Using Helm repository
# Add the AKHQ helm charts repository:
helm repo add akhq https://akhq.io/
# Install or upgrade
helm upgrade --install akhq akhq/akhq
# Requirements
# Chart version >=0.1.1 requires Kubernetes version >=1.14
# Chart version 0.1.0 works on previous Kubernetes versions
helm install akhq akhq/akhq --version 0.1.0


-------

#helm command

sudo helm -n kafka upgrade --install kafka-release bitnami/kafka --create-namespace \
--set kraft.clusterId=1235655456 \
--set persistent.size=8Gi,logpersistent.size=8Gi,volumePermissions.enabled=true,\
persistence.enabled=true,logPersistence.enabled=true,serviceAccount.create=true,rbac.create=true \
--version 26.9.0 -f kafka-values.yaml

#helm output for user-name and password
```
NAME: kafka-release
LAST DEPLOYED: Wed Aug 21 15:21:39 2024
NAMESPACE: kafka
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kafka
CHART VERSION: 26.9.0
APP VERSION: 3.6.1

** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    kafka-release.kafka.svc.cluster.local

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    kafka-release-controller-0.kafka-release-controller-headless.kafka.svc.cluster.local:9092
    kafka-release-controller-1.kafka-release-controller-headless.kafka.svc.cluster.local:9092
    kafka-release-controller-2.kafka-release-controller-headless.kafka.svc.cluster.local:9092

The CLIENT listener for Kafka client connections from within your cluster have been configured with the following security settings:
    - SASL authentication

To connect a client to your Kafka, you need to create the 'client.properties' configuration files with the content below:

security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
    username="user1" \
    password="$(kubectl get secret kafka-release-user-passwords --namespace kafka -o jsonpath='{.data.client-passwords}' | base64 -d | cut -d , -f 1)";

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run kafka-release-client --restart='Never' --image docker.io/bitnami/kafka:3.6.1-debian-11-r6 --namespace kafka --command -- sleep infinity
    kubectl cp --namespace kafka /path/to/client.properties kafka-release-client:/tmp/client.properties
    kubectl exec --tty -i kafka-release-client --namespace kafka -- bash

    PRODUCER:
        kafka-console-producer.sh \
            --producer.config /tmp/client.properties \
            --broker-list kafka-release-controller-0.kafka-release-controller-headless.kafka.svc.cluster.local:9092,kafka-release-controller-1.kafka-release-controller-headless.kafka.svc.cluster.local:9092,kafka-release-controller-2.kafka-release-controller-headless.kafka.svc.cluster.local:9092 \
            --topic test

    CONSUMER:
        kafka-console-consumer.sh \
            --consumer.config /tmp/client.properties \
            --bootstrap-server kafka-release.kafka.svc.cluster.local:9092 \
            --topic test \
            --from-beginning
```
# Helm commands for apache kafka chart and versions
strimzi https://strimzi.io/charts/
ngrok https://ngrok.github.io/kubernetes-ingress-controller
traefik https://helm/traefik.io/traefik 
jetstack https://charts.jetstack.io 
gitlab https://charts.gitlab.io 
bitnami https://charts.bitnami.com/bitnami
metrics-server https://kubernetes-sigs.github.io/metrics-server/
ingress-nginx https://kubernetes.github.io/ingress-nginx


# Adding bitnami repository to local helm repository

helm repo ls
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
help search repo bitnami
helm search repo bitnami/kafka
helm show values bitnami/kafka 
helm search repop bitnami/kafka --versions
helm show chart bitnami/kafka --versions 23.0.7
helm show readme bitnami/kafka --version 23.0.7
helm show all bitnami/kafka --version 23.0.7

