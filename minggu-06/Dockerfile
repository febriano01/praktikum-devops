# Tahap 1: builder
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Tahap 2: runtime
FROM python:3.11-slim
LABEL org.opencontainers.image.title="sentra"
LABEL org.opencontainers.image.vendor="Politeknik Negeri Batam"

RUN groupadd --system sentra && useradd --system --gid sentra --home /app sentra
WORKDIR /app

COPY --from=builder /install /usr/local
COPY --chown=sentra:sentra src/ ./src/

ENV HOST=0.0.0.0
ENV PORT=5000
EXPOSE 5000
USER sentra

HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD python3 -c "import urllib.request as u, sys; sys.exit(0 if u.urlopen('http://127.0.0.1:5000/health').status==200 else 1)"

CMD ["python3", "src/app.py"]
