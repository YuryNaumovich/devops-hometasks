docker run -d --name web_static -p 8081:80 hometask-image
docker cp index.html web_static:/var/www/html/index.html
