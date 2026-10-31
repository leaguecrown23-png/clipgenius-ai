
FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY clipgenius-ai-backend.zip /tmp/project.zip

RUN unzip -q /tmp/project.zip -d /tmp/project \
    && cp -a /tmp/project/clipgenius-ai/. /app/ \
    && rm -rf /tmp/project /tmp/project.zip \
    && pip install --no-cache-dir -r requirements.txt \
    && mkdir -p uploads outputs

EXPOSE 8000

CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
