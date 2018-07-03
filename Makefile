.PHONY: up down \
	traefik-up portainer-up nginx-up apache-up zmq-up \
	traefik-down portainer-down nginx-down apache-down zmq-down \
	zmq-ping zmq-reflect zmq-inc \
	help

TRAEFIK_NETWORK := traefik-net
#
# /etc/hosts
# 192.168.99.100   swarm.io
#
network-up:
	@docker network create --driver overlay --attachable $(TRAEFIK_NETWORK) || true

traefik-up: traefik-down network-up ## bring up traefik proxy service
	@docker stack deploy traefik -c traefik.yaml

traefik-down: ## tear down traefik proxy service
	@docker stack rm traefik || true

portainer-data-up:
	@docker volume create portainer-data || true
	# @docker volume create --driver local \
	# 	--opt type=tmpfs \
	# 	--opt device=tmpfs \
	# 	--opt o=size=100m,uid=1000 \
	# 	portainer-data

portainer-up: portainer-down portainer-data-up network-up ## bring up portianer service
	@docker stack deploy portainer -c portainer.yaml

portainer-down: ## tear down portainer service
	@docker stack rm portainer || true

apache-up: network-up ## bring up apache service
	@docker stack deploy apache -c apache.yaml

apache-down: ## tear down apache service
	@docker stack rm apache || true

nginx-up: nginx-down network-up ## bring up nginx service
	@docker stack deploy nginx -c nginx.yaml

nginx-down: ## tear down nginx service
	@docker stack rm nginx || true

zmq-up: zmq-down network-up ## bring up zmq microservices
	@docker stack deploy zmq -c zmq.yaml

zmq-down: ## tear down zmq microservices
	@docker stack rm zmq

zmq-clean: ## zmq: lower level service removal
	@docker service rm zmq_requestor || true
	@docker service rm zmq_responder || true

zmq-reflect: ## ex: make zmq-reflect
	@curl swarm.io/api/v1/reflect

zmq-ping: ## ex: make zmq-ping
	@curl swarm.io/api/v1/ping

zmq-inc: ## ex: make zmq-inc number=25
	@curl swarm.io/api/v1/increment/$(number)


up: traefik-up portainer-up nginx-up apache-up ## bring up all services

down: apache-down nginx-down portainer-down traefik-down ## tear down all services

help: ## this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
