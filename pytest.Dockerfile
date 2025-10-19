FROM python:3.14-slim

RUN apt-get update && \
    apt-get install -y tmux bash curl && \
    rm -rf /var/lib/apt/lists/*

# Install docker
RUN curl -fsSL https://get.docker.com | sh

# Install required packages.
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

# Copy your test files to the container and switch to that directory.
RUN mkdir "/tests"
COPY tests /tests
WORKDIR /tests

# Run pytest
CMD ["pytest"]
