## Dockerfile

Удалить образ
```bash
docker rmi {name}
```

Создание образа из dockerfile
```bash
docker build -t hometask-image .
```

Запуск контейнера с портами 80
```bash
docker run -d --name web_dynamic -p 8080:80 hometask-image
```
Запуск с именем
```bash
docker run -d --name web_static -p 8081:80 hometask-image
```

Удалить все контейнеры
```bash
docker system prune
```
## Dockerfile.multi

Создать образ
```bash
docker build -t word-cloud:v1 .
```

Создать контейнер
```bash
docker run -d --name web_cloud -p 8888:8888 word-cloud:v1
```
