# Total POS

> Punto de venta desarrollado por mera diversion, porque no? 🤷‍♂️

### ⚠️ En Desarrollo ⚠️

#### Usuarios por default en memoria

| Role  | User  | Password |
| ----- | ----- | -------- |
| Admin | admin | admin    |
| User  | user  | user     |


[WEB PREVIEW](https://total-3r4jyl7qo-ushieru.vercel.app/)

## Postgres
> Recomiendo levantar el proyecto con docker-compose.

Pueden iniciar la base de datos con el archivo [dump_db.sql](lib/backend/assets/postgres/dump_db.sql)
y modificar los parametros de la conexion en el [archivo de inicializacion](lib/app/config//setup_locator.dart) en el constructor de PostgresConnection.

## Soporte

* [X] Soporte para Windows
* [X] Soporte para Ubuntu
* [ ] Soporte para WSL2
* [ ] Soporte para MacOS

## TODO List

* [X] Agregar base de datos
* [ ] Agregar controlador de mesas
* [ ] Agregar controlador de impresoras
* [ ] Agregar soporte para GRPC
* [ ] Agregar cliente para dispositivos moviles
* [ ] Agregar Personalizacion
