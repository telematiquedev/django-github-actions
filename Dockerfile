FROM python:3.9-slim as builder

WORKDIR /app

RUN apt-get update \
    && apt-get install gcc libpq-dev python3-dev \
    --no-install-recommends -y

RUN python -m venv venv \
    && . venv/bin/activate \
    && pip install --upgrade pip \
    && pip install poetry

COPY pyproject.toml poetry.lock ./

ARG DEPENDENCIES=--no-dev

RUN . venv/bin/activate \
    && poetry config virtualenvs.create false \
    && poetry install --no-root ${DEPENDENCIES}

FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH=PYTHONPATH:/app/venv/lib/python3.9/site-packages

WORKDIR /app

COPY --from=builder /app/venv venv
COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu

COPY . .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]