FROM python:3.7-alpine

ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTPS_PROXY
ENV NO_PROXY=$NO_PROXY

LABEL name="trufflehog-actions-scan"
LABEL version="1.0.0"
LABEL repository="https://github.com/UnicornGlobal/trufflehog-actions-scan"
LABEL homepage="https://github.com/actions"

LABEL "com.github.actions.name"="Trufflehog Actions Scan"
LABEL "com.github.actions.description"="Scan repository for secrets with basic trufflehog defaults in place for easy setup."
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="yellow"

RUN pip3 install truffleHog==2.2.1
RUN apk --update add git less openssh && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/apk/*

RUN git config --global --add safe.directory '*'

ADD entrypoint.sh /entrypoint.sh
ADD regexes.json /regexes.json

ENTRYPOINT ["/entrypoint.sh"]
