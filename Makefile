#ISEC6000 Assessment 1
# Variables
CLUSTER_NAME=isec6000
CLUSTER_PATH=./K8S-cluster/cluster-config.yaml
MAINFEST_PATH=./K8S-manifest/

.SILENT: 
.PHONY: build

# Build Saleor platform image
build-platform:
	docker compose -f ./docker-compose.yml build

cluster:
	kind create cluster --config $(CLUSTER_PATH) --name $(CLUSTER_NAME)

deploy:
	kubectl apply -f $(MAINFEST_PATH)

build: build-platform cluster deploy

check:
	./image.sh

delete:
	kubectl delete -f $(MAINFEST_PATH)
	kind delete cluster --name $(CLUSTER_NAME)

#use with care
clean: delete
	docker container prune -f
	docker image prune -f
	docker volume prune -f
	docker system prune -f 