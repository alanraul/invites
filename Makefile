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

pip.install:
	docker-compose run --rm phx sh -c "pip install ${lib} --user"

pip.install.requirements:
	docker-compose run --rm phx sh -c "pip install -r pillow/requirements.txt --user"

pip.freeze:
	docker-compose run --rm phx sh -c "pip freeze"

pip.update.requirements:
	docker-compose run --rm phx sh -c "pip freeze > pillow/requirements.txt"

script.run:
	docker-compose run --rm phx sh -c 'python pillow/index.py "{\"texts\":[{\"text\":\"Despedida de soltera\",\"spacing\":10,\"size\":38,\"number_char\":20,\"font\":\"Gotham-Book.otf\",\"coordinates\":\"440,240\",\"color\":\"#11a1e4\",\"align\":\"left\"},{\"text\":\"DANIEL\",\"spacing\":10,\"size\":90,\"number_char\":13,\"font\":\"Gotham-Book.otf\",\"coordinates\":\"30,380\",\"color\":\"#2d2fa4\",\"align\":\"center\"},{\"text\":\"Calz. Gral. Mariano Escobedo 555, Polanco, Polanco V Secc, 11580 Ciudad de México, CDMX\",\"spacing\":10,\"size\":32,\"number_char\":28,\"font\":\"Gotham-Book.otf\",\"coordinates\":\"180,560\",\"color\":\"#e3717f\",\"align\":\"center\"},{\"text\":\"SÁBADO 6 DE JULIO A LAS 2:30 PM\",\"spacing\":10,\"size\":28,\"number_char\":30,\"font\":\"Gotham-Book.otf\",\"coordinates\":\"180,760\",\"color\":\"#e3717f\",\"align\":\"center\"}],\"template\":\"01.png\",\"name\":\"0b51eec8-e7a4-4f00-9fb2-73c444cba1e9\"}"'

script.gen.binary:
	docker-compose run --rm phx sh -c "pyinstaller pillow/index.py --onefile"
	cd src && rm -rf build index.spec pillow/dist
	mv src/dist src/pillow
