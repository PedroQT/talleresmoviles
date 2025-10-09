# 🍽️ Aplicación de Comidas - Flutter

Una aplicación Flutter que consume la API de TheMealDB para mostrar información detallada sobre comidas y recetas.

## 📖 Descripción

Esta aplicación implementa las mejores prácticas de Flutter para el consumo de APIs REST, incluyendo:
- Listado de comidas con navegación
- Vista de detalle con información completa
- Manejo robusto de estados (carga, éxito, error)
- Arquitectura limpia y separación de responsabilidades

## 🌐 API Utilizada

### TheMealDB API
- **URL Base**: `https://www.themealdb.com/api/json/v1/1`
- **Endpoint Principal**: `/search.php?s=Arrabiata`
- **Documentación**: [TheMealDB API](https://www.themealdb.com/api.php)

### Ejemplo de Respuesta JSON
```json
{
  "meals": [
    {
      "idMeal": "52771",
      "strMeal": "Spicy Arrabiata Penne",
      "strMealAlternate": null,
      "strCategory": "Vegetarian",
      "strArea": "Italian",
      "strInstructions": "Bring a large pot of water to a boil...",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
      "strTags": "Pasta,Curry",
      "strYoutube": "https://www.youtube.com/watch?v=1IszT_guI08",
      "strIngredient1": "penne rigate",
      "strMeasure1": "1 pound",
      ...
    }
  ]
}
```

## 🏗️ Arquitectura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── models/                   # Modelos de datos
│   ├── comidas.dart         # Modelo Comida y ComidaResponse
│   └── pokemon.dart         # Modelo Pokemon (ejemplo existente)
├── services/                # Servicios para consumo de APIs
│   ├── comidas_service.dart # Servicio para API de comidas
│   └── pokemon_service.dart # Servicio para API de Pokemon
├── views/                   # Pantallas de la aplicación
│   ├── comidas/
│   │   ├── comidas_list_view.dart    # Lista de comidas
│   │   └── comidas_detail_view.dart  # Detalle de comida
│   ├── home/               # Pantalla principal
│   ├── pokemons/           # Pantallas de Pokemon
│   └── ...                 # Otras pantallas
├── routes/                 # Configuración de rutas
│   └── app_router.dart     # Definición de rutas con go_router
├── widgets/                # Widgets reutilizables
│   ├── base_view.dart      # Widget base para pantallas
│   └── custom_drawer.dart  # Drawer de navegación
└── themes/                 # Configuración de temas
    └── app_theme.dart      # Tema de la aplicación
```

## 🛣️ Rutas Definidas

### Configuración con go_router

| Ruta | Nombre | Parámetros | Descripción |
|------|--------|------------|-------------|
| `/comidas` | `comidas` | Ninguno | Lista principal de comidas |
| `/comida/:idMeal` | `comida_detail` | `idMeal` (String) | Detalle de una comida específica |

### Ejemplos de Navegación

```dart
// Navegar a lista de comidas
context.go('/comidas');

// Navegar a detalle de comida
context.push('/comida/52771');

// Desde el código de la lista
onTap: () {
  context.push('/comida/${comida.idMeal}');
}
```

## 🔧 Características Técnicas

### ✅ Requisitos Implementados

1. **Consumo de API y Listado**
   - ✅ GET request a TheMealDB API
   - ✅ ListView.builder para renderizado eficiente
   - ✅ Imágenes con manejo de errores
   - ✅ Estados de carga, éxito y error
   - ✅ Service independiente
   - ✅ Modelo con fromJson

2. **Navegación con go_router**
   - ✅ Navegación entre pantallas
   - ✅ Paso de parámetros (idMeal)
   - ✅ Rutas con nombre
   - ✅ Botón "atrás" funcional

3. **Manejo de Estado**
   - ✅ Try/catch para errores
   - ✅ Verificación de statusCode
   - ✅ Estados reflejados en UI
   - ✅ Botón de reintentar

4. **Buenas Prácticas**
   - ✅ No peticiones en build()
   - ✅ Uso de initState()
   - ✅ Future/async/await
   - ✅ Mensajes claros al usuario

### 📱 Funcionalidades de la UI

- **Lista de Comidas**: Cards con imagen, nombre, categoría y área
- **Detalle de Comida**: Imagen grande, ingredientes, instrucciones
- **Estados de Carga**: CircularProgressIndicator con mensajes
- **Manejo de Errores**: Iconos y mensajes descriptivos
- **Navegación**: Drawer lateral con acceso a todas las secciones

## 🚀 Instalación y Uso

### Prerrequisitos
- Flutter SDK (>=3.9.0)
- Dart SDK
- Conexión a internet para consumir la API

### Instalación

1. Clonar el repositorio:
```bash
git clone <url-del-repositorio>
cd parqueadero_2025_g2
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Configurar variables de entorno (archivo `.env`):
```env
COMIDAS_API_URL=https://www.themealdb.com/api/json/v1/1
```

4. Ejecutar la aplicación:
```bash
flutter run
```

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^16.2.1      # Navegación declarativa
  http: ^1.5.0            # Cliente HTTP
  flutter_dotenv: ^6.0.0  # Variables de entorno
  cupertino_icons: ^1.0.8 # Iconos iOS
```

## 🎯 Estados de la Aplicación

### Estado de Carga
- CircularProgressIndicator centrado
- Texto descriptivo "Cargando comidas..."

### Estado de Éxito
- Lista de comidas con ListView.builder
- Cards con imagen, nombre y metadatos
- Navegación fluida al detalle

### Estado de Error
- Icono de error
- Mensaje descriptivo del error
- Botón "Reintentar" para nueva petición

### Estado Vacío
- Mensaje "No se encontraron comidas"
- Icono representativo

## 🔄 Flujo de la Aplicación

1. **Inicio**: Usuario abre la aplicación
2. **Navegación**: Selecciona "COMIDAS" desde el drawer
3. **Lista**: Ve la lista de comidas con estado de carga
4. **Selección**: Toca una comida para ver el detalle
5. **Detalle**: Ve información completa con ingredientes e instrucciones
6. **Regreso**: Usa el botón atrás para volver a la lista

## 🎨 Capturas de Pantalla

> **Nota**: Las capturas de pantalla mostrarían:
> - Lista de comidas con cards y imágenes
> - Estado de carga con CircularProgressIndicator
> - Pantalla de detalle con información completa
> - Estados de error con botones de reintentar

## 🤝 Contribución

Este proyecto fue desarrollado como parte del taller de desarrollo móvil, implementando las mejores prácticas de Flutter para consumo de APIs REST.

## 📄 Licencia

Este proyecto es de uso educativo.
