# Stage 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y gcc python3-dev
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim
WORKDIR /app

# Varnost: Ustvari ne-privilegiranega uporabnika
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Kopiraj samo potrebne datoteke iz builderja
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser

EXPOSE 8080
CMD ["python", "app.py"]