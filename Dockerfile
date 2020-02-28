FROM python:3.7

LABEL repository="https://github.com/UnicornGlobal/trufflehog-actions-scan"
LABEL homepage="https://github.com/actions"

RUN apt-get update && apt-get install -y \
    git less openssh && rm -rf /var/lib/apt/lists/*
RUN pip install gitdb2==3.0.0 truffleHog==2.1.11

COPY entrypoint.sh /entrypoint.sh
COPY regexes.json /regexes.json

ENTRYPOINT ["/entrypoint.sh"]
