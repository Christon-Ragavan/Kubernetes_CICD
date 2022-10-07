### COMMON #####################################################################
ARG type=base

### BASE IMAGE #################################################################
FROM python:3.10-slim-buster as base_environment
# Install python requirements
ENV TZ=Etc/UTC

ENV \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONDONTWRITEBYTECODE=1 \
  PIP_NO_CACHE_DIR=0 \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VERSION=1.1.13 \
  POETRY_HOME="/opt/poetry" \
  PATH="$PATH:/opt/poetry/bin" \
  KAGGLE_USERNAME='christonragavan' \
  KAGGLE_KEY='64c0e86deed6b20bba4100691588a9bb' \
  VIRTUAL_ENV=/app/venv

RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir poetry==${POETRY_VERSION}
# Uncomment the following two lines, if needed rustup for transformer package
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#RUN $HOME/.carge/env

WORKDIR /app
COPY pyproject.toml requirements.txt ./
RUN poetry install --no-dev --no-root --no-ansi
RUN pip install --no-cache-dir -r requirements.txt


### BASE TEST IMAGE ############################################################
FROM base_environment as test_environment
RUN poetry install --no-root --no-ansi
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY /src .

### Extraction ENVIRONMENT ############################################################
# hadolint ignore=DL3006
FROM ${type}_environment as main_environment
# Copy source code
WORKDIR /app
COPY /src .