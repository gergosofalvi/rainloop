# hardware/rainloop

![](https://i.goopics.net/nI.png)

FORKED:
[https://github.com/hardware/rainloop](https://github.com/hardware/rainloop)

DockerHub Multi-platform ARM64 & AMD64 build:
[https://hub.docker.com/layers/geriapp/latest/images/sha256-95c194c144ad5851e3a97ab15c42294a5f1e9278c30cab87a736c6eee357cd0b?context=explore](https://hub.docker.com/layers/geriapp/latest/images/sha256-95c194c144ad5851e3a97ab15c42294a5f1e9278c30cab87a736c6eee357cd0b?context=explore)

### What is this ?

Rainloop is a simple, modern & fast web-based client. More details on the [official website](http://www.rainloop.net/).

### Features

* Lightweight & secure image (no root process)
* Based on Alpine
* Latest Rainloop **Community Edition** (stable)
* Contacts (DB) : sqlite, mysql or pgsql (server not built-in)
* With Nginx and PHP8.3
* Postfixadmin-change-password plugin

### Build-time variables

* **GPG\_FINGERPRINT** : fingerprint of signing key

### Ports

* **8888**

### Environment variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **UID** | rainloop user id | *optional* | 991 |
| **GID** | rainloop group id | *optional* | 991 |
| **UPLOAD\_MAX\_SIZE** | Attachment size limit | *optional* | 25M |
| **LOG\_TO\_STDOUT** | Enable nginx and php error logs to stdout | *optional* | false |
| **MEMORY\_LIMIT** | PHP memory limit | *optional* | 128M |

### Docker-compose.yml

``` yml
# Full example :
# https://github.com/hardware/mailserver/blob/master/docker-compose.sample.yml

rainloop:
  image: hardware/rainloop
  container_name: rainloop
  volumes:
    - /mnt/docker/rainloop:/data
  depends_on:
    - mailserver
```

#### How to setup

https://github.com/hardware/mailserver/wiki/Rainloop-initial-configuration