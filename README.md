# nginx-webdav-docker

## how to run
by docker
``` bash
docker build -t nginx-webdav .
docker run --name nginx-webdav -p 30080:80 -it nginx-webdav

# docker exec -it nginx-webdav bash
# docker rm nginx-webdav
```

by docker compose
``` bash
docker compose up -d
# docker compose exec nginx-webdav bash
# docker compose logs -f
# docker compose down
```

check
``` bash
curl http://localhost:30080/

curl -X PUT -T README.md http://localhost:30080/upload/
# see /var/www/dav/upload/README.md
```

measure
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
* dav.confの`server_name`を設定しなかったり、条件にマッチしないときはより優先であると判断された順番のルールが自動的に適用されることに注意
  * すべての`server_name`にマッチしなかったときに、設定の記述の順番に関係なく、`200 OK`が`404 Not Found`よりも優先されたような挙動となった(要確認)

### how to debug
``` bash
# how to update dav.conf file
docker cp ./etc/nginx/conf.d/dav.conf nginx-webdav:/etc/nginx/conf.d/dav.conf
docker cp ./etc/nginx/nginx.conf nginx-webdav:/etc/nginx/
```
