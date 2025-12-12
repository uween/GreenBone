FROM registry.community.greenbone.net/community/gvmd:23.10.0

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get clean
RUN mkdir -p /run/sshd
RUN mkdir -p /opt/ssh
RUN mkdir -p /home/gvmd
RUN ssh-keygen -q -N "" -t ecdsa -f /opt/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t ed25519 -f /opt/ssh/ssh_host_ed25519_key
RUN cp /etc/ssh/sshd_config /opt/ssh/
RUN sed -i 's/gvmd:x:1001:1001::\/home\/gvmd:\/bin\/false/gvmd:x:1001:1001::\/home\/gvmd:\/home\/gvmd\/ssh-sock.sh/' /etc/passwd
RUN chmod 600 /opt/ssh/*
RUN chmod 644 /opt/ssh/sshd_config
RUN chown -R gvmd /opt/ssh/
RUN echo 'gvmd:def@ul7pa55' | chpasswd
RUN sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/opt\/ssh\/ssh_host_ecdsa_key/' /opt/ssh/sshd_config
RUN sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/opt\/ssh\/ssh_host_ed25519_key/' /opt/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ADD ssh-sock.sh /home/gvmd/ssh-sock.sh
RUN chmod +x /home/gvmd/ssh-sock.sh
ADD start.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint


EXPOSE 22
CMD ["/usr/local/bin/start-gvmd"]
