APP_CONTAINER_NAME = app
RUN_APP = docker compose exec $(APP_CONTAINER_NAME)
RUN_UV = $(RUN_APP) uv run

prepare:
	docker compose up -d --build

up:
	docker compose up -d

build:
	docker compose build

down:
	docker compose down

format:
	$(RUN_UV) ruff format .

lint:
	$(RUN_UV) ruff check .

test:
	$(RUN_UV) pytest

app:
	docker exec -it $(APP_CONTAINER_NAME) bash
