# AIQuizMakerAPI

To work locally with the API use the url

```shell
https://localhost:3000/api/v1
```

## Getting Started

This Dockerized Stack is based on [this repo](https://github.com/nickjj/docker-rails-example).

1. Copy `.env.example` and customise (if necessary):

```shell
cp .env.example .env
```

2. Add your Google API Key to `GOOGLE_API_KEY`. For more details view [Google Help](https://support.google.com/googleapi/answer/6158862?hl=en).

3. Make sure you use `Docker Compose V2`:

```shell
docker compose version
```

4. Finally, run the stack with:

```shell
./run stack
```
