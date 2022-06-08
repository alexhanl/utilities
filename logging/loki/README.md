
## Integration of grafana loki with k8s
https://grafana.com/docs/loki/latest/clients/fluentbit/#kubernetes

### Installation

You can run Fluent Bit as a Daemonset to collect all your Kubernetes workload logs.

To do so you can use our Fluent Bit helm chart:

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install fluent-bit grafana/fluent-bit \
    --set loki.serviceName=loki.svc.cluster.local
By default it will collect all containers logs and extract labels from Kubernetes API (container_name, namespace, etc..).

Alternatively you can install the Loki and Fluent Bit all together using:

helm upgrade --install loki-stack grafana/loki-stack \
    --set fluent-bit.enabled=true,promtail.enabled=false



### Query
https://grafana.com/docs/loki/latest/logql/log_queries/

{app="flog"} | pattern `<timestamp> <stream> F <json_payload>` | line_format "{{.json_payload}}" | json | status=500