FROM alpine

RUN apk update && apk add ansible openssh-client openssh-keygen sshpass && \
    adduser -D -s /bin/sh ansible

USER ansible
RUN mkdir /home/ansible/playbook && \
    ssh-keygen -t rsa -f /home/ansible/.ssh/id_rsa -N ''

WORKDIR /home/ansible/playbook

ENTRYPOINT [ "ansible-playbook" ]