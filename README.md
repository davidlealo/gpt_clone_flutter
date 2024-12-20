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
## **Instalar Dependencias**

1. **Instalar las dependencias de Flutter:**
   ```bash
   flutter pub get
   ```
2. **Reparar el caché de dependencias (si es necesario):**
   ```bash
   flutter pub cache repair
   ```
3. **Verificar dependencias y actualizar:**
   Si tienes problemas con versiones incompatibles, utiliza:
   ```bash
   flutter pub upgrade
   ```

## **Iniciar el Proyecto**

### **Backend**

El backend utiliza Dart y está configurado en el archivo `server/backend.dart`.

1. **Ejecutar el backend manualmente:**
   ```bash
   dart run server/backend.dart
   ```
Esto iniciará el servidor en `http://localhost:8080`.

2. **Alternativa: Ejecutar backend y frontend simultáneamente con `start_all.dart`:**
   ```bash
   dart run start_all.dart
   ```
Este script inicia el backend y el frontend al mismo tiempo.

### **Frontend**

1. **Ejecutar Flutter en Chrome:**
   ```bash
   flutter run -d chrome
   ```
2. **Solucionar problemas**
   Si aparece un error relacionado con múltiples dispositivos conectados, asegúrate de que Chrome está configurado como destino predeterminado:
   ```bash
   flutter devices
   flutter run -d chrome
   ```

### **Variables de Entorno**

Este proyecto utiliza un archivo `.env` para manejar la clave de API de OpenAI de manera segura. Sigue estos pasos para configurarlo:

1. **Crea la carpeta `assets/` en la raíz del proyecto (si no existe).**

   La estructura del proyecto debería verse así:

## **Estructura del Proyecto**

El proyecto está organizado de la siguiente manera:

```plaintext
gpt_clone_flutter/
├── lib/                # Código principal del frontend en Flutter
│   ├── main.dart       # Punto de entrada de la aplicación Flutter
│   ├── widgets/        # Componentes visuales reutilizables
│   ├── services/       # Lógica para conectarse con el backend
├── assets/             # Carpeta para recursos estáticos
│   ├── .env            # Archivo de configuración para variables de entorno
├── server/             # Código del backend en Dart
│   ├── backend.dart    # Archivo principal del servidor Dart
├── pubspec.yaml        # Archivo de configuración de dependencias
├── start_all.dart      # Script para iniciar backend y frontend simultáneamente
├── README.md           # Documentación del proyecto
```

---

2. **Crea el archivo `.env` dentro de la carpeta `assets/`.**

Dentro del archivo `.env`, añade tu clave de API de OpenAI en el siguiente formato:
```plaintext
OPENAI_API_KEY=sk-tu-clave-api-aquí
```
3. **Declara el archivo `.env` en el archivo `pubspec.yaml`.**

   Abre el archivo `pubspec.yaml` y asegúrate de declarar la carpeta `assets`:
   ```yaml
   flutter:
     assets:
       - assets/.env
    ```

4. **Carga las variables de entorno en `main.dart`.**

   En el archivo `main.dart`, asegúrate de cargar el archivo `.env` con el paquete `flutter_dotenv`:
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';

   Future<void> main() async {
     await dotenv.load(fileName: "assets/.env");
     runApp(MyApp());
   }
   ```
5. **Asegúrate de excluir el archivo `.env` del control de versiones.**

   Para evitar exponer tu clave de API, agrega el archivo `.env` a tu archivo `.gitignore`:

```bash
# Ignorar archivo .env
assets/.env

```



## **Contribuciones**

Si quieres contribuir a este proyecto, sigue estos pasos:

1. Realiza un fork del repositorio.
2. Crea una nueva rama para tu funcionalidad:
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```
3. Realiza tus cambios y haz un commit:
   ```bash
   git commit -m "Descripción de los cambios realizados"
   ```
4. Sube los cambios a tu fork:
   ```bash
   git push origin feature/nueva-funcionalidad
   ```
5. Crea un Pull Request desde tu fork al repositorio principal.

---

## **Licencia**

Este proyecto está bajo la licencia MIT. Puedes consultar el archivo [LICENSE](LICENSE) para obtener más información.

---

## **Contacto**

Si tienes preguntas, sugerencias o algún problema con el proyecto, no dudes en contactarme:

- **Email:** [davidlealo@gmail.com](mailto:davidlealo@gmail.com)
- **GitHub:** [https://github.com/davidlealo](https://github.com/davidlealo)
- **LinkedIn:** [https://www.linkedin.com/in/davidlealo/](https://www.linkedin.com/in/davidlealo/)

---

¡Gracias por usar este proyecto! 😊  
Si encuentras algún problema, abre un issue o envía una Pull Request. ¡Tu ayuda es bienvenida!




