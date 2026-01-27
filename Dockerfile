FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends software-properties-common curl git build-essential sudo ca-certificates gpg lsb-release && \
    apt-get install -y ansible && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /ansible

COPY . .

CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

