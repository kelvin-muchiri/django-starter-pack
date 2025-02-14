# Django Starter Pack

![Django Starter Pack](https://github.com/user-attachments/assets/9b1fce7d-02c4-4398-8e6c-fe84b925398e)

DjangoStarterPack is a powerful, ready-to-use collection of boilerplate code and configurations designed to save you days of setting up new Django projects.

## Components

- **Django**: The go-to Python web framework for building scalable, maintainable applications with built-in ORM, authentication, and security features.
- **Docker**: Ensures consistency across development, testing, and production environments by containerizing the entire stack.
- **PostgreSQL**: A robust, ACID-compliant relational database known for its scalability, JSONB support, and strong concurrency handling.
- **Redis**: A high-performance in-memory store used for caching, real-time data processing, and Celery task brokering.
- **Celery**: A distributed task queue that enables asynchronous job processing to improve application responsiveness.
- **Amazon S3**: Scalable cloud storage with seamless integration for serving static and media files.
- **Mailjet**: A reliable email API for sending transactional and marketing emails with high deliverability.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Python >=3.10.10 installed on your machine. [Learn how to install multiple Python versions using Pyenv](https://realpython.com/intro-to-pyenv/)

An active python virtual environment. [Learn how to activate virtual environments using Pyenv](https://realpython.com/intro-to-pyenv/#virtual-environments-and-pyenv)

[Docker](https://docs.docker.com/engine/install/) and [Docker Compose v2](https://docs.docker.com/compose/migrate/) installed.

### Development

#### Setting up the development environment

Change directory into the root of the project

Install the development requirements in your local virtual environment by executing in the terminal

```sh
pip install -r requirements/dev.txt
```

Create a `.env` file. Copy the contents of `.env_sample` into the newly created `.env`. Enter
the necessary values for the keys listed

Build a new image and spin up the containers

```sh
docker compose up -d
```

After the containers are up, run the database migrations by running

```sh
docker compose exec backend python manage.py migrate
```

#### Other useful commands

Collect static files

```sh
docker compose exec backend python manage.py collectstatic
```

Login into the Django app container

```sh
docker compose exec -it backend /bin/sh
```

To create a new app

```sh
mkdir -p backend/apps/myapp
python manage.py startapp myapp backend/apps/myapp
```

If an update to the pre-commit hooks is required run in terminal,

```sh
pre-commit autoupdate
```

### Package installation

Package installation is via `pip-compile` provided by the [pip-tools](https://pypi.org/project/pip-tools/) package. Install this package in your environment.

To add a new package, update the corresponding `requirements/<environment>.in` depending on the package's purpose.

For instance, if the package will be used by all environments, add it to `requirements/base.in`, else if it will be used only in development add in `requirements/dev.in`. Packages only available in the production environment will be added in `requirements/prod.in`.

Compile the corresponding `<environment>.txt` by running the command

```sh
pip-compile --output-file=requirements/<environment>.txt requirements/<environment>.in
```

e.g `pip-compile --output-file=requirements/base.txt requirements/base.in`

After making these changes, rebuild your Docker image:

```sh
docker-compose down
docker-compose build
docker-compose up
```

To uninstall a package remove the package from the `.in` file and compile. Finally rebuild the image.

### Running tests

To run all tests

```sh
docker compose exec backend pytest -vv -o cache_dir=/tmp/pytest_cache
```

To run tests on a specific module

```sh
docker compose exec backend pytest backend/apps/users -vv -o cache_dir=/tmp/pytest_cache
```

To avoid caching issues in Docker, we specify `-o cache_dir=/tmp/pytest_cache`.

## Support

[![Buy me a coffee](https://github.com/user-attachments/assets/4aa1f078-853b-4c65-a485-a440b7f3b936)](https://ko-fi.com/kelvinmuchiri)

## License

[MIT License](https://github.com/kelvin-muchiri/django-starter-pack/blob/main/LICENSE)
