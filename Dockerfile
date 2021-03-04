FROM python:3.7-alpine as base

ENV PYTHONDONTWRITEBYTECODE 1

COPY requirements_dev.txt requirements_dev.txt ./
RUN apk add --update --no-cache --virtual .build-deps \
    build-base \
    postgresql-dev \
    libffi-dev \
    python3-dev \
    libffi-dev \
    jpeg-dev \
    zlib-dev \
    musl-dev \
    libpq 

RUN pip install -U pip \
    && pip install -r requirements_dev.txt

FROM base as dev

RUN apk add --update --no-cache libpq libjpeg-turbo

COPY --from=base /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/
COPY --from=base /usr/local/bin/ /usr/local/bin/



ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONPATH /code:$PYTHONPATH

COPY script.sh /
EXPOSE 8000
WORKDIR /code
COPY code /code
ENTRYPOINT [ "/script.sh" ]

