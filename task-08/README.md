##### DOCKER ######

# Удалить образ
docker rmi {name}

# Создание образа из dockerfile
docker build -t hometask-image .

# Запуск контейнера с портами 80
docker run -d --name web_dynamic -p 8080:80 hometask-image

# Запуск с именем
docker run -d --name web_static -p 8081:80 hometask-image

# Удалить все контейнеры
docker system prune

#### Dockerfile.multi

# Создать образ
docker build -t word-cloud:v1 .

# Создать контейнер
docker run -d --name web_cloud -p 8888:8888 word-cloud:v1
