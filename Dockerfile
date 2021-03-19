FROM haproxy:2.3
COPY ssl.crt+key haproxy.cfg /usr/local/etc/haproxy/
