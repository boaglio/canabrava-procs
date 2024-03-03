# canabrava

```
                           ___.                              
  ____ _____    ____ _____ \_ |______________ ___  _______   
_/ ___\\__  \  /    \\__  \ | __ \_  __ \__  \\  \/ /\__  \  
\  \___ / __ \|   |  \/ __ \| \_\ \  | \// __ \\   /  / __ \_
 \___  >____  /___|  (____  /___  /__|  (____  /\_/  (____  /
     \/     \/     \/     \/    \/           \/           \/   PROCS
```

Uma versão Bash da [rinha do backend 2ª edição](https://github.com/zanfranceschi/rinha-de-backend-2024-q1) 2024/Q1

Fork da [versão Bash do Leandro](https://github.com/leandronsp/canabrava) com os todos SQLs para dentro do banco (em stored functions) e outros pequenos ajustes.

É a rinha de Bash-End! 

## Requisitos

* [Docker](https://docs.docker.com/get-docker/)
* [Gatling](https://gatling.io/open-source/), a performance testing tool
* Make (optional)

## Stack

* 2 Bash apps 
* 1 PostgreSQL (com Stored Functions)
* 1 NGINX

## Usage

```bash
$ make help

Usage: make <target>
  help                       Prints available commands
  start.dev                  Start the rinha in Dev
  start.prod                 Start the rinha in Prod
  docker.stats               Show docker stats
  health.check               Check the stack is healthy
  stress.it                  Run stress tests
  docker.build               Build the docker image
  docker.push                Push the docker image
```

## Inicializando a aplicação

```bash
$ docker compose up -d nginx

# Ou então utilizando Make...
$ make start.dev
```

Testando a app:

```bash
$ curl -v http://localhost:9999/clientes/1/extrato

# Ou então utilizando Make...
$ make health.check
```

## Unleash the madness

Colocando Gatling no barulho:

```bash
$ make stress.it 
$ open stress-test/user-files/results/**/index.html
```

----

[ASCII art generator](http://www.network-science.de/ascii/)
