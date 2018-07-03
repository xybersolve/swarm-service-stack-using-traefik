# Swarm Service Stacks using Traefik

> A few boilerplate services as a micro-service launch pad.
Traefik proxy for Microservice & REST routing.

## Local domain emulation

Get IP address using `$(docker-machine ip ${swarm_leader})`.

```sh

  ./update-hosts <ip-address>


  # or manually
  $ vim /etc/hosts

  192.168.99.100   swarm.io

```

### ZMQ - API Versioning (/api/v1)
```sh

  # service uses intra-communication call to 0MQ (ZeroMQ) microservice socket
  $ curl swarm.io/api/v1/ping
  $ curl swarm.io/api/v1/increment/128

  # return basic container information for load balancing
  $ curl swarm.io/api/v1/reflect


```
## Makefile

```sh

$ make help

apache-down          tear down apache service
apache-up            bring up apache service
help                 this help screen
nginx-down           tear down nginx service
nginx-up             bring up nginx service
portainer-down       tear down portainer service
portainer-up         bring up portianer service
traefik-down         tear down traefik proxy service
traefik-up           bring up traefik proxy service
zmq-down             tear down zmq microservices
zmq-up               bring up zmq microservices
zmq-inc              ex: make zmq-inc number=25
zmq-ping             ex: make zmq-ping
zmq-reflect          ex: make zmq-reflect
up                   bring up all services
down                 tear down all services

```

##### TODO: Acme (let's ecnrypt) certificate creation

## [License](LICENSE.md)
