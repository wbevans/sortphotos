FROM docker.io/python:3.11-bookworm
LABEL org.opencontainers.image.source="https://github.com/wbevans/sortphotos"

ENV DEBIAN_FRONTEND=noninteractive
ARG UID=1000
ARG GID=100
RUN useradd --create-home --no-log-init -u "${UID}" -g "${GID}" python

COPY ./src/sortphotos.py /usr/bin
RUN apt update && apt install -y exiftool && rm -rf /var/lib/apt/lists/*
RUN mkdir /usr/bin/Image-ExifTool
RUN ln -s /usr/bin/exiftool /usr/bin/Image-ExifTool
USER python

ENTRYPOINT ["/usr/bin/sortphotos.py"]