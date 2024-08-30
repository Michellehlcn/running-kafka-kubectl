provider "kubernetes" {
    config_path="~/.kube/config"
}

provider "helm" {
    kubernetes {
      config_path = "~/.kube/config"
    }
}

// add the helm repository for bitnami 
resource "helm_release" "kafka" {
    name ="kafka"
    repository = "https://charts.bitnami.com/bitnami"
    chart="kafka"
    values = [
        <<EOF
        kafka:
          enabled: true
          kraftMode: true
          replicaCount: 3
          auth:
            clientProtocol: plaintext
            interBrokerProtocol: plaintext
          configurationOverrides:
          "auto.create.topics.enable": "true"
          "delete.topic.enable": "true" 
          "log.retention.hours": "168" 
        EOF
    ]
}

// add the AKHQ helm chart repository to terraform 
# resource "helm_release" "akhq" {
#     name="akhq"
#     repository="https://akhq.io/helm"
#     chart="akhq"

#     values = [ 
#         <<EOF 
#         akhq:
#           server: 8080 
#         connections:
#           my-cluster:
#             properties: 
#               bootstrap.servers: kafka.kafka.svc.cluster.local:9092
#         EOF
#     ]
# }

//