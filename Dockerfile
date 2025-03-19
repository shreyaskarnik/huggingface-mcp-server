# Generated by https://smithery.ai. See: https://smithery.ai/docs/config#dockerfile
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy necessary files
COPY pyproject.toml ./
COPY README.md ./
COPY src ./src
COPY uv.lock ./

# Upgrade pip and install build tools and the package
RUN pip install --upgrade pip \
    && pip install hatchling \
    && pip install . --ignore-requires-python --no-build-isolation

CMD ["huggingface"]
