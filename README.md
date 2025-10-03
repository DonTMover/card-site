# Hugo site in Docker

How to build and run locally:

1. Build Docker image:
   docker build -t mysite:latest .

2. Run container:
   docker run -d -p 8080:80 --name mysite mysite:latest

3. Open http://localhost:8080

Alternate with docker-compose:
   docker-compose up --build

Notes:
- If your theme uses SCSS, keep the `klakegg/hugo:ext` image (Hugo Extended).
- Make sure `baseURL` в config.toml установлен корректно (например, https://example.com/)
  или используйте относительные пути (relativeURLs = true) для корректных ссылок.
- Для деплоя: пушьте образ в Docker Hub / GitHub Container Registry и на сервере `docker pull` + `docker run`,
  либо просто склонируйте репозиторий на сервер и выполните `docker build` и `docker run`.