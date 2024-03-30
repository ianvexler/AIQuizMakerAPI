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
    - Add your OpenAI API Key to `OPEN_AI_API_KEY`. This requires ChatGpt Plus & credits. For more details follow initial steps in [Setting Up GPT-4 with OpenAI API]([https://support.google.com/googleapi/answer/6158862?hl=en](https://wandb.ai/onlineinference/gpt-python/reports/Setting-Up-GPT-4-In-Python-Using-the-OpenAI-API--VmlldzozODI1MjY4)).

4. Make sure you use `Docker Compose V2`:

```shell
docker compose version
```

4. Finally, run the stack with:

```shell
./run stack
```

5. (Suggested) Setup the database
```shell
./run rails db:migrate db:seed
```

## Notes

To Create a Quiz use the endpoint

```shell
http://localhost:3000/api/v1/quizzes/gemini (To use gemini)

http://localhost:3000/api/v1/quizzes/gpt (To use gpt-4)
```

With a request format e.g.

```shell
{
    "quiz": {
        "title": "ALevel Derivatives Exam",
        "goal": "To prove understanding on ALevel difficulty derivative questions",
        "instructions": "Make the last question difficult"
    }
}
```

To view the quiz generated from the response of this request using axios look for:

```shell
response.data.quiz.quiz_data
```

This is the JSON response by gemini in a string format. Make sure to parse it into a JSON format. 
