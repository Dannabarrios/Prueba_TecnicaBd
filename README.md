# Proyecto Base de Datos - Sistema Aerolínea

## Descripción

Este proyecto corresponde al análisis, organización y estabilización de un modelo de base de datos en PostgreSQL, estructurado por dominios funcionales y gestionado mediante Liquibase.

## Estructura del proyecto

* Organización por dominios funcionales (geografía, clientes, vuelos, pagos, etc.)
* Separación de objetos DDL (tablas, índices)
* Control de cambios mediante Liquibase
* Despliegue mediante contenedores Docker

## Tecnologías utilizadas

* PostgreSQL
* Liquibase
* Docker

## Script base

El archivo SQL incluido corresponde al modelo entregado como insumo en la prueba técnica. Este ha sido reorganizado en dominios funcionales para su mantenimiento y evolución.

## Ejecución del proyecto

1. Levantar contenedores:
   docker-compose up -d

2. Ejecutar migraciones:
   docker-compose run liquibase update

## Autor

Danna Barrios
