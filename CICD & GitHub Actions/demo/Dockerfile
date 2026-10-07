FROM python:3.12-alpine
WORKDIR /app
COPY app ./app
CMD ["python", "-c", "from app.calculator import add; print('Calculator Docker result:', add(2, 3))"]
