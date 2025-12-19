FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY app ./app
COPY gunicorn.conf.py .
ENV PATH=/root/.local/bin:$PATH

CMD ["gunicorn", "app.main:app", "-c", "gunicorn.conf.py"]
