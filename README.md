# Django Starter Pack

DjangoStarterPack is a powerful, ready-to-use collection of boilerplate code and configurations designed to save you days of setting up new Django projects.

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

Login into Django app container

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

## Support

[![Buy me a coffee](https://github.com/user-attachments/assets/5f78b888-6f6c-4f9e-bc19-64fee8a99b16)](https://ko-fi.com/kelvinmuchiri)

## License

[MIT License](https://github.com/kelvin-muchiri/django-starter-pack/blob/main/LICENSE)
