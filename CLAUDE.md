# AGENTS Guidelines for This Repository

This repository contains a FastAPI application under `app/`. When using an agent (e.g. Cursor), follow these guidelines so development stays consistent with CI and Docker.

## Development server

- **Docker (recommended):** `make prepare` starts the stack; the API is served at http://127.0.0.1:8000 with `--reload` (see `docker-compose.yaml`).
- **Local (uv):** `uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000` so the port matches compose unless you intentionally use another (e.g. debugger on 8080 in `.vscode/launch.json`).

After dependency changes, restart the server so the process picks up the updated environment.

## Dependencies

If you add or change dependencies:

1. Update `pyproject.toml` and refresh the lockfile (`uv lock` or `uv add <package>`).
2. Commit `uv.lock` with your code changes.

## Coding conventions

- Prefer Python (`.py`) for new code.
- HTTP status codes: follow `.cursor/rules/status_codes.md` (use `fastapi.status` constants in app and test code, not raw numeric literals).

## Useful commands

`make format` and `make test` run **inside** the `app` container via Docker Compose (`docker compose exec`). Use `make prepare` first so the container is up.

| Command       | Purpose                    |
| ------------- | -------------------------- |
| `make format` | Ruff check (fix) + format  |
| `make test`   | Pytest in the container    |

Without Docker, use the same checks as CI: `uv run pytest` (and ruff via `uv run ruff` if needed).

## Testing instructions

- Find the CI plan in `.github/workflows/`.
- Run `uv run pytest` to match the workflow’s test step.

## PR instructions

- Branch name: `feat/<short-description>` (optionally include the GitHub issue id, e.g. `feat/123-short-description`).
- Title format: `<Title>`
- Before committing: run `make format` and `make test` when using Docker; otherwise run the equivalent `uv run` commands above.

These practices keep agent-assisted work aligned with FastAPI, uv, and this repo’s Docker setup.

## Directory Structure
- This project follows Clean Architecture and Domain-Driven Design (DDD) principles.
- Each layer has a clearly defined responsibility, protecting business logic from external dependencies.

```
.
├── Makefile
├── README.md
├── docker-compose.yml
├── migrations/                  # Alembic migration files
└── app/
    ├── main.py                  # Entrypoint
    ├── alembic.ini              # Migration config
    ├── pyproject.toml           # Dependency management
    ├── uv.lock                  # Lock file
    ├── config/                  # Cross-cutting concerns (env, logging, etc.)
    │
    ├── domain/                  # ★ Domain Layer - zero external dependencies
    │   └── models/              # Entity / Aggregate Root
    │
    ├── usecase/                 # ★ Usecase Layer - orchestrates business flow
    │
    ├── infrastructure/          # ★ Infrastructure Layer
    │   ├── database.py          # DB config and session management
    │   └── repositories/        # Repository implementations
    │
    ├── presentation/            # ★ Presentation Layer
    │   ├── routers/             # FastAPI routers
    │   ├── schemas/             # Pydantic Request / Response schemas
    │   └── dependency.py        # DI (FastAPI Depends)
    └── tests/  
