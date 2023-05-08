FROM ubuntu:focal AS base
ENV HOME /root
WORKDIR /$HOME
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS john
ARG TAGS
RUN addgroup --gid 1000 john
RUN adduser --gecos john --uid 1000 --gid 1000 --disabled-password john
USER john
WORKDIR /home/john

FROM base
WORKDIR /$HOME
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

