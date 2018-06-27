# Invites.

### Configurar variables de entorno.

El archivo __.env.dist__ contiene un listado actualizado de las variables de entorno necesarias para el proyecto, se debe copiar ese archivo a uno nuevo llamado __.env__

Exporta las variables

```shell
export $(cat .env | xargs)
```


Necesitaras crear un archivo llamando google_credentials.json dentro de la carpeta secrets.

Preguntar al equipo por los valores a usar.


### Configurar del entorno.

```shell
make bootstrap
```

### Iniciar el entorno en background.

```shell
make start logs
```

- Ahora se puedes ir a http://localhost:9001

## Comandos útiles.

### Comandos útiles para el setup.

- __make bootstrap__: Configura el entorno por primera vez.
- __make reset__: Hace un hard reset borrando todas las configuraciones y contenedores.

### Comandos útiles para manejar el entorno.

- __make start__: Levanta el entorno en background.
- __make restart__: Reinicia la aplicación phx.
- __make restart.postgres__: Reinicia la base de datos postgres.
- __make stop__: Detiene la aplicación phx.
- __make stop.postgres__: Detiene la base de datos postgres.
- __make logs__: Muestra los logs de la aplicación phx.
- __make logs.postgres__: Muestra los logs de la base de datos postgres.
- __make shell__: Muestra la shell de la aplicación phx.
- __make shell.postgres__: Muestra la shell de la base de datos postgres.
- __make shell.test__: Muestra un shell con una sesión de postgres.

### Comandos útiles para del desarrollo.

- __make seed__: Ejecuta seed para cargar datos de prueba.
- __make gettext__: Actualiza archivos POT y PO.
- __make routes__: Muestra las rutas.
- __make credo__: Ejecuta credo.
- __make test__: Ejecuta todos los tests.
- __make coverage__: Ejecuta el coverage de cada app por separado.
- __make deps.update__: Actualiza dependencias.
- __make ecto.reset__: Hace un reset a la base de datos.
- __make ecto.setup__: Actualiza migraciones.
- __make update__: Actualiza paquetes y base de datos Postgres.

### Comandos útiles para el CI/CD.

- __make check.all__: Corre tests, coverage y credo.
- __make build.release__: Genera un release.
