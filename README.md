# Instrucciones para Descargar y Ejecutar el Proyecto

Este documento describe los pasos necesarios para clonar, instalar dependencias, y ejecutar el proyecto tanto para el frontend (Flutter) como para el backend (Dart).

## **Requisitos Previos**

1. **Instalar Flutter**
   - Descarga Flutter desde [flutter.dev](https://flutter.dev/docs/get-started/install).
   - Asegúrate de añadir Flutter a tu PATH:
     ```bash
     export PATH="$PATH:`pwd`/flutter/bin"
     ```
   - Verifica que Flutter esté correctamente instalado:
     ```bash
     flutter doctor
     ```

2. **Instalar Dart**
   - Dart está incluido con Flutter. Sin embargo, si necesitas Dart de forma independiente, sigue estas instrucciones:
     - Descarga Dart desde [dart.dev](https://dart.dev/get-dart).
     - Verifica la instalación con:
       ```bash
       dart --version
       ```

3. **Navegador Chrome**
   - Asegúrate de tener Google Chrome instalado, ya que este proyecto está configurado para ejecutarse en Flutter Web.

## **Clonar el Repositorio**

Clona el repositorio desde GitHub:
```bash
git clone https://github.com/davidlealo/gpt_clone_flutter.git
cd gpt_clone_flutter
```
