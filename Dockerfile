# Pull official base image
FROM python:3.10.10-alpine

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ARG PROJECT_ENV=prod

# Create the app user, group, and application directory
RUN addgroup -S app && \
    adduser -S app -G app && \
    mkdir -p /srv/backend && \
    chown app:app /srv/backend

# Set the working directory
WORKDIR /srv/backend

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    # Dependencies for psycopg
    postgresql-dev gcc musl-dev libffi-dev \
    # Dependency for python-magic
    file \
    # Dependencies for PayPal SDK
    openssl-dev libffi-dev \
    # Dependencies for Pillow library
    jpeg-dev zlib-dev libjpeg-turbo-dev

# Copy requirements files and install Python dependencies
COPY requirements/${PROJECT_ENV}.txt requirements/${PROJECT_ENV}.txt
RUN pip install --upgrade pip && \
    pip install -r requirements/${PROJECT_ENV}.txt --no-cache-dir

# Copy project files into the working directory
COPY . /srv/backend

# Set permissions for the application directory
RUN chown -R app:app /srv/backend

# Switch to the non-root user
USER app

# Expose the port the application runs on
EXPOSE 8000

# Define the command to run the application
CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "backend.wsgi:application"]
