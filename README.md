
# 🚗 Taller Flutter - Autenticación JWT y Consumo de API

Aplicación Flutter que implementa autenticación JWT contra API pública, almacenamiento seguro y evidencia visual del consumo y persistencia de datos.

## � Descripción

Este proyecto muestra:
- Registro y login de usuario contra API JWT
- Almacenamiento de datos sensibles (token) en `flutter_secure_storage`
- Almacenamiento de datos no sensibles (nombre, email) en `shared_preferences`
- Interfaz visual para evidenciar los datos almacenados
- Navegación con GoRouter

## 🔑 API Utilizada

- **Base URL:** https://parking.visiontic.com.co/api
- **Endpoints:**
  - `/users` (registro)
  - `/login` (login)
  - `/users/{id}` (consulta por id)
- **Documentación:** [Swagger](https://parking.visiontic.com.co/api/documentation)

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── app_entry.dart
├── models/
├── services/
│   └── auth_service.dart
├── views/
│   ├── login/
│   │   ├── login_view.dart
│   │   └── register_view.dart
│   └── evidence/
│       └── evidence_view.dart
├── routes/
│   └── app_router.dart
└── widgets/
```

## 🛣️ Rutas Principales

| Ruta         | Descripción                  |
|--------------|-----------------------------|
| `/login`     | Login de usuario            |
| `/register`  | Registro de usuario         |
| `/evidence`  | Evidencia de sesión y datos |
| `/`          | Pantalla principal          |

## 🗂️ Almacenamiento Local

- **shared_preferences:**
  - `name`: Nombre del usuario
  - `email`: Email del usuario
- **flutter_secure_storage:**
  - `access_token`: Token JWT

## 👀 Evidencias Visuales

La pantalla de evidencia muestra:

- **SharedPreferences**
  - Nombre y email guardados
- **SecureStorage**
  - Token JWT completo
  - Estado visual del token (presente/ausente)

## �️ Instalación y Ejecución

1. Clona el repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd talleresmoviles
   ```
2. Instala dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecuta la app:
   ```bash
   flutter run
   ```

## 📦 Dependencias Clave

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^16.2.1
  http: ^1.5.0
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
```

## 💡 Flujo de Autenticación

1. El usuario se registra o inicia sesión
2. Se almacena el token JWT en `flutter_secure_storage`
3. Se almacenan nombre y email en `shared_preferences`
4. La pantalla de evidencia muestra los datos guardados
5. Al cerrar sesión, se eliminan todos los datos locales

## 📸 Ejemplo de Evidencia Visual

```
┌─────────────────────────────┐
│ SharedPreferences           │
│ ────────────────────────── │
│ Nombre: pedro               │
│ Email: pedrodqt11@gmail.com │
└─────────────────────────────┘

┌─────────────────────────────┐
│ SecureStorage               │
│ ────────────────────────── │
│ Token JWT: eyJ0eXAiOiJKV1Qi... │
│ Estado: Presente            │
└─────────────────────────────┘
```

## 📝 Notas

- El token nunca se muestra en la UI principal, solo en la pantalla de evidencia.
- El flujo de login y registro está protegido y navega automáticamente según el estado de sesión.
- El cierre de sesión elimina todos los datos locales y redirige al login.

## 📄 Licencia

Proyecto educativo para taller de desarrollo móvil.
