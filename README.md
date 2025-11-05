
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
# talleresmoviles

## Documentación: integración "Universidades" (Firebase)

Este README ha sido reemplazado para documentar los cambios agregados en la rama feature relacionados con la gestión de universidades usando Firebase Firestore.

### Resumen

Se implementó un CRUD básico en tiempo real para la colección `universidades` en Firestore. Los cambios incluyen:

- Modelo de datos (`lib/models/universidades.dart`) — `UniversidadFb`.
- Servicio Firestore (`lib/services/universidades_service.dart`) — operaciones CRUD y streams.
- Vistas: lista y formulario en `lib/views/universidades/`.
- Registro de rutas en `lib/routes/app_router.dart`.
- Entrada en el Drawer (`lib/widgets/custom_drawer.dart`) para acceso rápido.

---

## Archivos principales añadidos/modificados

- `lib/models/universidades.dart` — Modelo `UniversidadFb` con campos: `id`, `nit`, `nombre`, `direccion`, `telefono`, `paginaWeb`. Incluye `fromMap` y `toMap`.
- `lib/services/universidades_service.dart` — Servicio con métodos: `watchUniversidadById`, `watchUniversidades`, `getUniversidades`, `addUniversidad`, `updateUniversidad`, `deleteUniversidad`, `getUniversidadById`.
- `lib/views/universidades/universidades_list_view.dart` — Lista adaptable (Grid/List) que usa `watchUniversidades()`.
- `lib/views/universidades/universidad_form_view.dart` — Formulario para crear/editar universidades.
- `lib/routes/app_router.dart` — Se añadieron rutas:
  - `/universidades` (lista)
  - `/universidades/create` (crear)
  - `/universidades/edit/:id` (editar)
- `lib/widgets/custom_drawer.dart` — Se añadió el ítem "Universidades" que navega a la ruta `universidades`.

## Modelo: UniversidadFb

Campos y mapping:

- `id` — id del documento (String)
- `nit` — (String)
- `nombre` — (String)
- `direccion` — (String)
- `telefono` — (String)
- `paginaWeb` — (String) mapeado como `pagina_web` en Firestore

Ejemplo en Firestore:

```json
{
  "nit": "890.123.456-7",
  "nombre": "UCEVA",
  "direccion": "Cra 27A #48-144, Tuluá - Valle",
  "telefono": "+57 602 2242202",
  "pagina_web": "https://www.uceva.edu.co"
}
```

## Servicio: UniversidadesService

Provee operaciones síncronas y streams para interactuar con Firestore. Observaciones:

- `addUniversidad` utiliza actualmente `collection.add(...)` — Firestore genera el id del documento.
- Si prefieres usar el `nit` como id del documento, podemos cambiar `addUniversidad` a `doc(nit).set(...)` para garantizar unicidad basada en NIT.

## Vistas

1) `UniversidadesListView`

- Lista en tiempo real de universidades.
- Diseño responsive: Grid en pantallas anchas, List en móviles.
- Permite eliminar documentos y navegar a crear/editar.

2) `UniversidadFormView`

- Formulario para crear o editar.
- En modo editar (`id` provisto) carga el documento y llena los campos.

## Rutas registradas

- `/universidades` — nombre `universidades`
- `/universidades/create` — nombre `universidades.create`
- `/universidades/edit/:id` — nombre `universidades.edit`

Estas rutas se encuentran en `lib/routes/app_router.dart`.

## Drawer

Se añadió una entrada en el Drawer con el icono `Icons.school` y la etiqueta "Universidades" que navega a la ruta nombrada `universidades`.

## Cómo probar (rápido)

1. Instala dependencias y ejecuta el analizador:

```powershell
cd C:\Users\pedroq\Desktop\talleresmoviles
flutter pub get
flutter analyze
```

2. Ejecuta la app:

```powershell
flutter run -d <device-id>
```

3. Probar flujo:

- Abrir Drawer → seleccionar "Universidades".
- Crear una universidad con el formulario.
- Verificar que aparezca en la lista en tiempo real.
- Editar y eliminar para validar las operaciones.

## Resultado del análisis estático

Se ejecutó `flutter analyze` tras estos cambios; se encontraron solo `info` y `warning` (recomendaciones y imports sin usar). No hay errores blocking relacionados con las nuevas funcionalidades.

## Recomendaciones y siguientes pasos

- (Opcional) Usar `nit` como id del documento para evitar duplicados y facilitar búsquedas: cambiar `addUniversidad` a `doc(nit).set(...)`.
- Añadir validaciones para teléfono y URL.
- Limpiar warnings (imports no usados) y reemplazar `print` por logging.
- Añadir pruebas unitarias para el modelo y el servicio.

---

Si quieres que actualice la estrategia de ID, limpie warnings o agregue pruebas, dime cuál y lo implemento.
