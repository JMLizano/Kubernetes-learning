#! /bin/bash

# Take a look at config
kubectl config view

# Take a look at dasboard  http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/

# Install kafka and zookeeper
helm install --name kafka --namespace kafka incubator/kafka

# Deploy testclient
kubectl create -f test-kafka.yml

# Deploy AGW
kubectl -n kafka create -f agw/

HOST=10.10.1.193:30100
curl "http://$HOST/_aws_health_check"
while :
do
	curl "http://$HOST/__bca.gif?vid=f4737763869344868fe2b42fd959b977&acc=M-cBg37LYykO&typ=articleView&ts=1426853097448&arg=f6d65f3b3a1119a616fa4c20676d92e351447a68&cks=__caka%3DZJltaOT9z0ZU5xcrT.1402672307083.68.0.4.3%3B%20__cakb%3D2.1426853090415.1426853090415.1426853097371.0.7.2%3B%20&rnd=1985563768&ver=0.7.2&blg=en-us&bje=1&tit=tous%20overwrite%201%20%7C%20Staging%20blog%203&hst=blogs.staging.aws.brandcrumb.com&pth=%2Fblog3%2F&ref=http%3A%2F%2Fblogs.staging.aws.brandcrumb.com%2Fblog3%2F&lsh=%3Fp%3D3339&scd=24&srs=1551x900"
	sleep 1
done

# Listen to messages
kubectl -n kafka exec -it testclient -- /usr/bin/kafka-console-consumer --bootstrap-server kafka-kafka:9092 --topic articleView 