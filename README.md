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

2. Add your Google API Key to `GOOGLE_API_KEY`. For more details view [Google Help](https://support.google.com/googleapi/answer/6158862?hl=en).

3. Make sure you use `Docker Compose V2`:

```shell
docker compose version
```

4. Finally, run the stack with:

```shell
./run stack
```
## Notes

To Create a Quiz use the endpoint

```shell
http://localhost:3000/api/v1/quizzes
```

With a request format e.g.

```shell
{
    "quiz": {
        "title": "Micro Economics",
        "goal": "To understand Micro Economics",
        "instructions": "Complete this quiz"
    }
}
```

To view the quiz generated from the response of this request using axios look for:

```shell
response.data.quiz_data
```

This is the JSON response by gemini in a string format. Make sure to parse it into a JSON format. 