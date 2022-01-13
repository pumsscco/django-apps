# syntax=docker/dockerfile:1
FROM python:3.8.12-slim-buster
WORKDIR /app
COPY . .
RUN cp ali-cache.list /etc/apt/sources.list \
    && mkdir ~/.pip && cp pip.conf ~/.pip \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev gcc && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r requirements.txt
USER nobody:nogroup
CMD [ "python3", "manage.py" , "runserver", "0.0.0.0:5571"]