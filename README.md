# Total POS

> Punto de venta desarrollado por mera diversion, porque no? 🤷‍♂️

### ⚠️ En Desarrollo ⚠️

> La implementacion con postgres es la mas avanzada [echale un ojo](https://github.com/ushieru/total_pos)

Por el momento el sistema funciona solo con repositorios en memoria.
Habra una version web de ejemplo con las funciones basicas del sistema pero no se planea dar soporte web al proyecto (por ahora, o por lo menos hasta que el WASM de Flutter pese >2Mb).

#### Usuarios por default en memoria

| Role         | User      |  Password  |
|--------------|-----------|------------|
| Admin        | admin     | admin      |
| User         | user      | user       |


[WEB PREVIEW](https://total-3r4jyl7qo-ushieru.vercel.app/)

## Soporte

* [X] Soporte para Windows
* [X] Soporte para Ubuntu
* [ ] Soporte para WSL2
* [ ] Soporte para MacOS

## TODO List

* [ ] Agregar base de datos
* [ ] Agregar controlador de mesas
* [ ] Agregar controlador de impresoras
* [ ] Agregar soporte para GRPC
* [ ] Agregar cliente para dispositivos moviles
* [ ] Agregar Personalizacion
