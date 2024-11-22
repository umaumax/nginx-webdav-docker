# nginx-webdav-docker

``` bash
docker build -t nginx-webdav .
docker run --name nginx-webdav -p 30080:80 -it nginx-webdav

docker exec -it nginx-webdav bash
docker rm nginx-webdav

curl http://localhost:30080/

curl -X PUT -T README.md http://localhost:30080/upload/
# see /var/www/dav/upload/README.md
```

``` bash
# mac
mkfile -v 100M 100M.bin
mkfile -v 500M 500M.bin

# 12.54sec
/usr/bin/time bash -c "seq 1 5 | parallel -a - curl -X PUT -T 100M.bin http://localhost:30080/upload/{}"

# 15.13sec
/usr/bin/time bash -c "seq 1 1 | parallel -a - curl -X PUT -T 500M.bin http://localhost:30080/upload/{}"
```

## NOTE
* dav.confの`server_name`を設定しないと`curl`が無視されることに注意

### how to debug
``` bash
# how to update dav.conf file
docker cp ./etc/nginx/conf.d/dav.conf nginx-webdav:/etc/nginx/conf.d/dav.conf
```
