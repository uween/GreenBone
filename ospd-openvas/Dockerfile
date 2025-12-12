FROM registry.community.greenbone.net/community/ospd-openvas:22.7.1

# Install dhclient and clean up apt cache
RUN apt-get update && \
    apt-get install -y isc-dhcp-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Allow the user to run dhclient without sudo
RUN mkdir -p /home/ospd-openvas/bin && \
    echo 'dhclient' > /home/ospd-openvas/bin/dhclient && \
    chmod +x /home/ospd-openvas/bin/dhclient && \
    export PATH=/home/ospd-openvas/bin:$PATH

# Ensure entrypoint runs with necessary permissions
COPY dhclient-script.sh /usr/local/bin/dhclient-script.sh
RUN chmod +x /usr/local/bin/dhclient-script.sh

# Ensure entrypoint runs with necessary permissions
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/dhclient-script.sh"]
CMD ["ospd-openvas", "--config", "/etc/gvm/ospd-openvas.conf", "-f", "-m", "666"]
