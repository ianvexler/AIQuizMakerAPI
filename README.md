# AIQuizMakerAPI

To work locally with the API use this as the base URL:

```shell
http://localhost:3000/api/v1/
```

## Getting Started

This Dockerized Stack is based on [this repo](https://github.com/nickjj/docker-rails-example).

1. Copy `.env.example` and customise (if necessary):

```shell
cp .env.example .env
```

2. Add API Keys in `.env`
    - Add your Google API Key to `GOOGLE_API_KEY`. For more details view [Google Help](https://support.google.com/googleapi/answer/6158862?hl=en).

4. Make sure you use `Docker Compose V2`:

```shell
docker compose version
```

4. Finally, run the stack with:

```shell
./run stack
```

## Notes

Free trials are not included in every country for Gemini API, therefore using a VPN and connecting to a country with a free trial (e.g. USA) might be required 
 
