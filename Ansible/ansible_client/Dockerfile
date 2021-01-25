FROM debian

RUN apt update && apt install -y openssh-server sudo python3 && \
    mkdir /var/run/sshd && \
    useradd -m -s /bin/bash -G sudo ansible && \
    echo 'ansible:'$(echo 'SUxPdmVEZXZPcHMK'|base64 -d)| chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]
