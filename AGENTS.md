# AGENTS Guidelines for This Repository

This repository contains a FastAPI application under `app/`. When using an agent (e.g. Cursor), follow these guidelines so development stays consistent with CI and Docker.

## 1. Development server

- **Docker (recommended):** `make prepare` starts the stack; the API is served at http://127.0.0.1:8000 with `--reload` (see `docker-compose.yaml`).
- **Local (uv):** `uv run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000` so the port matches compose unless you intentionally use another (e.g. debugger on 8080 in `.vscode/launch.json`).

After dependency changes, restart the server so the process picks up the updated environment.

## 2. Dependencies

If you add or change dependencies:

1. Update `pyproject.toml` and refresh the lockfile (`uv lock` or `uv add <package>`).
2. Commit `uv.lock` with your code changes.

## 3. Coding conventions

- Prefer Python (`.py`) for new code.
- HTTP status codes: follow `.cursor/rules/status_codes.md` (use `fastapi.status` constants in app and test code, not raw numeric literals).

## 4. Useful commands

`make format` and `make test` run **inside** the `app` container via Docker Compose (`docker compose exec`). Use `make prepare` first so the container is up.

| Command       | Purpose                    |
| ------------- | -------------------------- |
| `make format` | Ruff check (fix) + format  |
| `make test`   | Pytest in the container    |

Without Docker, use the same checks as CI: `uv run pytest` (and ruff via `uv run ruff` if needed).

## 5. Testing instructions

- Find the CI plan in `.github/workflows/`.
- Run `uv run pytest` to match the workflow’s test step.

## 6. PR instructions

- Branch name: `feat/<short-description>` (optionally include the GitHub issue id, e.g. `feat/123-short-description`).
- Title format: `<Title>`
- Before committing: run `make format` and `make test` when using Docker; otherwise run the equivalent `uv run` commands above.

These practices keep agent-assisted work aligned with FastAPI, uv, and this repo’s Docker setup.
