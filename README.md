## Description

*Very* simple solution for testing an HAProxy config file and TLS cert/key bundle to validate before deployment. This is *heavily* based on the info at https://hub.docker.com/_/haproxy/, mainly adding a config file to allow for easy TLS certificate/key testing.

## How to Use

1. Clone the repository.
1. Create your concatenated TLS cert chain + key (e.g `cat ssl.crt ssl.key > ssl.crt+key`) and ensure the output file (`ssl.crt+key`) is in the local directory.
1. Build the image (e.g. `docker build -t haproxy-config-test .`).
1. Run the container to test your config (e.g. `docker run -it --rm haproxy-config-test haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg`)

If everything is valid in your config/certificate, you should see output like the following:

```
$ docker run -it --rm haproxy-config-test haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
Configuration file is valid
```

Alternatively, if you've provided an invalid TLS cert/key bundle (e.g. certificates are out of order):

```
$ docker run -it --rm haproxy-config-test haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
[NOTICE] 077/142431 (1) : haproxy version is 2.3.7-2d39ce3
[NOTICE] 077/142431 (1) : path to executable is /usr/local/sbin/haproxy
[ALERT] 077/142431 (1) : parsing [/usr/local/etc/haproxy/haproxy.cfg:13] : 'bind :443' : inconsistencies between private key and certificate loaded '/usr/local/etc/haproxy/ssl.crt+key'.
[ALERT] 077/142431 (1) : parsing [/usr/local/etc/haproxy/haproxy.cfg:14] : 'bind :::443' : inconsistencies between private key and certificate loaded '/usr/local/etc/haproxy/ssl.crt+key'.
[ALERT] 077/142431 (1) : Error(s) found in configuration file : /usr/local/etc/haproxy/haproxy.cfg
[ALERT] 077/142431 (1) : Fatal errors found in configuration.
```
