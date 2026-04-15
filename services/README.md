# Services

Application source code for the Feeds Dispatcher. Two services, each independently deployable.

| Service | Folder | Role |
|---------|--------|------|
| App1 – Ingestion | [app1-ingestion/](app1-ingestion/) | Receives feeds from ACRS, validates, stores in S3, enqueues to SQS |
| App2 – Dispatch | [app2-dispatch/](app2-dispatch/) | Consumes SQS, transforms, publishes to EventBridge |

## Monorepo Conventions

- Each service has its own `Dockerfile`, `.env.example`, `src/`, and `tests/`
- Services share no runtime code — they are independently deployable
- Shared types/schemas (if needed) live in a `shared/` folder at this level — do not create until genuinely needed by both services
- CI pipeline builds and scans each service independently (see `.github/workflows/`)

## Local Development

Each service README has its own quickstart. Generally:

```bash
cd services/app1-ingestion
cp .env.example .env
# fill in .env values
docker build -t app1-ingestion .
docker run --env-file .env app1-ingestion
```
