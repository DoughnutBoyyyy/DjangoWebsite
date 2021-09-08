FROM python:3.7-slim as production

ENV PYTHONUNBUFFERED=1
WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
    bash \
    build-essential \
    gcc \
    libffi-dev \
    musl-dev \
    openssl \
    postgresql \
    libpq-dev

COPY DjangoWebsite/requirements/prod.txt ./DjangoWebsite/requirements/prod.txt
RUN pip install -r ./DjangoWebsite/requirements/prod.txt

COPY manage.py ./manage.py
COPY setup.cfg ./setup.cfg
COPY DjangoWebsite ./DjangoWebsite

EXPOSE 8000

FROM production as development

COPY DjangoWebsite/requirements/dev.txt ./DjangoWebsite/requirements/dev.txt
RUN pip install -r ./DjangoWebsite/requirements/dev.txt

COPY . .   