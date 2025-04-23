FROM python:3.13-slim

WORKDIR /app
COPY app.py .
COPY requirements.txt .
RUN pip install --no-cache-dir --no-python-version-warning -qq -r requirements.txt
EXPOSE 8004
CMD ["python", "./app.py"]
