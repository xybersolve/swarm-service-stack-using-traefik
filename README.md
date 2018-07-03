# Swarm Service Stacks using Traefik

> A few boilerplate services as a micro-service launch pad.
Traefik proxy for Microservice & REST routing.

## Local domain emulation

Get IP address using `$(docker-machine ip ${swarm_leader})`.

```sh
 $ vim /etc/hosts

 192.168.99.100   swarm.io

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
up                   bring up all services
down                 tear down all services

```

##### TODO: Acme (let's ecnrypt) certificate creation

## [License](LICENSE.md)
