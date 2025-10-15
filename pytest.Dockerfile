FROM python:3.14-alpine

RUN apk add --no-cache tmux docker bash --update

# Install required packages.
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

# Copy your test files to the container and switch to that directory.
RUN mkdir "/tests"
COPY tests /tests
WORKDIR /tests

# Run pytest
CMD ["pytest"]
