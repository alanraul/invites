##################################################################
#### Bootstrap Commands
##################################################################

setup:
	docker build --tag codigobicentenario/phoenix:ubuntu .

bootstrap:
	docker-compose run --rm -T --no-deps phx sh -c "mix deps.get && mix deps.compile"
	make ecto.setup

reset:
	docker-compose run --rm --no-deps phx sh -c "rm -rf /app/src/deps/* /app/src/_build/dev/*"
	docker-compose stop
	docker-compose rm -f
	docker-compose run --rm --no-deps phx sh -c "rm -rf /src/venv/"

##################################################################
#### Docker Commands
##################################################################

start:
	docker-compose up -d phx

restart:
	docker-compose restart phx

restart.postgres:
	docker-compose restart postgres

stop:
	docker-compose stop phx

stop.postgres:
	docker-compose stop postgres

logs:
	docker-compose logs -f phx

logs.postgres:
	docker-compose logs -f postgres

shell:
	docker-compose run --rm phx sh

shell.postgres:
	docker-compose run --rm postgres sh -c "psql -U postgres -h postgres ${db}"

shell.test:
	ENV=test docker-compose run --rm phx sh

##################################################################
#### Development Commands
##################################################################

seed:
	docker-compose run --rm --no-deps phx sh -c "mix run priv/repo/seeds.exs"

routes:
	docker-compose run --rm  phx sh -c "mix phx.routes"

credo:
	ENV=test docker-compose run --rm --no-deps phx sh -c "mix credo"

test:
	ENV=test docker-compose run --rm  phx sh -c "mix test"

coverage:
	ENV=test docker-compose run --rm phx sh -c "mix coveralls.html"

coverage.show.linux:
	sensible-browser ./src/cover/excoveralls.html

coverage.show.mac:
	open ./src/cover/excoveralls.html

deps.update:
	docker-compose run --rm phx sh -c "mix deps.clean --unused && mix deps.get && mix deps.compile"

ecto.reset:
	docker-compose run --rm phx sh -c "mix ecto.reset"

ecto.rollback:
	docker-compose run --rm phx sh -c "mix ecto.rollback"

ecto.migrate:
	docker-compose run --rm phx sh -c "mix ecto.migrate"

ecto.setup:
	docker-compose run --rm phx sh -c "mix ecto.setup"

ecto.gen.migration:
	docker-compose run --rm phx sh -c "mix ecto.gen.migration ${file}"

update:
	make deps.update ecto.setup

##################################################################
#### CI/CD Commands
##################################################################

build.release:
	cd src && mix deps.get && mix deps.compile && mix release --no-tar --env=prod

##################################################################
#### Scripts Commands
##################################################################

pip.install.requirements:
	docker-compose run --rm phx sh -c "pip install -r pillow/requirements.txt --user"

pip.freeze:
	docker-compose run --rm phx sh -c "pip freeze"

script.run:
	docker-compose run --rm phx sh -c 'python pillow/index.py "{\"texts\":[{\"text\":\"hola\",\"size\":18,\"font\":\"TypoSlab_demo.otf\",\"coordinates\":\"40,80\",\"column_width\":22,\"color\":\"#000000\"},{\"text\":\"hola\",\"size\":18,\"font\":\"TypoSlab_demo.otf\",\"coordinates\":\"40,120\",\"column_width\":22,\"color\":\"#000000\"},{\"text\":\"hola\",\"size\":18,\"font\":\"TypoSlab_demo.otf\",\"coordinates\":\"40,160\",\"column_width\":22,\"color\":\"#000000\"},{\"text\":\"hola\",\"size\":18,\"font\":\"TypoSlab_demo.otf\",\"coordinates\":\"40,200\",\"column_width\":22,\"color\":\"#000000\"}],\"template\":\"01.png\",\"name\":\"437a6a4f-6edc-4aad-b20c-0f109df0ac47\"}"'

script.gen.binary:
	docker-compose run --rm phx sh -c "pyinstaller pillow/index.py --onefile"
	cd src && rm -rf build index.spec
	mv src/dist src/pillow
