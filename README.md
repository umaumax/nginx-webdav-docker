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

## NOTE
* dav.confの`server_name`を設定しないと`curl`が無視されることに注意
