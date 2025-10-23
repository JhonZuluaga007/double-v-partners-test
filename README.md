# Double V Partners - Test Técnico Flutter

Aplicación móvil desarrollada en Flutter siguiendo **Clean Architecture** con organización **Feature-First** y gestión de estado con **flutter_bloc**.

## 📋 Características

- ✅ **Arquitectura Limpia (Clean Architecture)** con separación en capas: Domain, Data y Presentation
- ✅ **Organización Feature-First** para mejor escalabilidad
- ✅ **Gestión de Estado** con flutter_bloc
- ✅ **Inyección de Dependencias** con GetIt
- ✅ **Navegación** con GoRouter
- ✅ **Consumo de API REST** con Dio
- ✅ **Manejo de Errores** funcional con Dartz (Either<Failure, Success>)
- ✅ **Tests Unitarios** con mocktail y bloc_test

## 🎯 Funcionalidades

### 1. Lista de Usuarios
- Visualización de todos los usuarios
- Pull-to-refresh para actualizar la lista
- Navegación a detalle de usuario
- Estado de carga y manejo de errores

### 2. Crear Usuario
- Formulario completo con validaciones:
  - Nombre (requerido)
  - Apellido (requerido)
  - Fecha de nacimiento (selector de fecha)
  - Direcciones (múltiples, con país, departamento y municipio)
- Agregar/eliminar direcciones dinámicamente
- Validaciones en tiempo real
- Indicadores de carga durante la creación

### 3. Detalle de Usuario
- Información completa del usuario
- Avatar con inicial del nombre
- Fecha de nacimiento formateada
- Listado de todas las direcciones
- Fechas de creación y actualización
- Manejo de errores con opción de reintentar

## 🏗️ Arquitectura

```
lib/
├── core/                          # Código compartido
│   ├── constants/                 # Constantes de la app
│   ├── error/                     # Excepciones y Failures
│   ├── navigation/                # Rutas (GoRouter)
│   ├── network/                   # Cliente HTTP (Dio)
│   └── theme/                     # Temas de la app
│
├── features/                      # Features (Feature-First)
│   └── users/                     # Feature de usuarios
│       ├── data/                  # Capa de Datos
│       │   ├── datasources/       # Remote & Local data sources
│       │   ├── models/            # Modelos con serialización JSON
│       │   └── repositories/      # Implementación de repositorios
│       │
│       ├── domain/                # Capa de Dominio
│       │   ├── entities/          # Entidades de negocio
│       │   ├── repositories/      # Interfaces de repositorios
│       │   └── usecases/          # Casos de uso
│       │
│       └── presentation/          # Capa de Presentación
│           ├── bloc/              # BLoC (Estado)
│           ├── pages/             # Pantallas
│           └── widgets/           # Widgets reutilizables
│
├── di/                            # Inyección de dependencias (GetIt)
└── main.dart                      # Punto de entrada
```

## 📦 Dependencias Principales

```yaml
dependencies:
  # State Management
  flutter_bloc: ^9.1.1

  # Functional Programming
  dartz: ^0.10.1

  # Value Equality
  equatable: ^2.0.7

  # Dependency Injection
  get_it: ^8.2.0

  # Navigation
  go_router: ^16.3.0

  # HTTP Client
  dio: ^5.4.0

  # Date formatting
  intl: ^0.19.0

dev_dependencies:
  # Testing
  bloc_test: ^10.1.3
  mocktail: ^1.0.4
```

## 🔌 API Endpoints

### POST /api/users
Crea un nuevo usuario.

**Request Body:**
```json
{
  "name": "Juan",
  "last_name": "Perez",
  "birth_date": "1990-05-15T10:30:00Z",
  "addresses": [
    {
      "country": "Colombia",
      "department": "Antioquia",
      "municipality": "Medellín"
    }
  ]
}
```

### GET /api/users
Obtiene la lista de todos los usuarios.

**Response:**
```json
[
  {
    "id": "a1b2c3d4-uuid-example-5678",
    "name": "Juan",
    "last_name": "Perez",
    "birth_date": "1990-05-15T10:30:00Z",
    "created_at": "2025-10-23T16:45:00Z",
    "updated_at": "2025-10-23T16:45:00Z",
    "addresses": [
      {
        "id": "addr-uuid-001",
        "country": "Colombia",
        "department": "Antioquia",
        "municipality": "Medellín"
      }
    ]
  }
]
```

### GET /api/users/:id
Obtiene un usuario específico por ID.

## 🚀 Instalación y Ejecución

### Prerrequisitos
- Flutter SDK >= 3.9.2
- Dart SDK >= 3.9.2

### Pasos

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd double_v_partners_test
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Variables de Entorno**

Copia el archivo de ejemplo y edítalo con tu configuración:
```bash
cp .env.example .env
```

Edita `.env` con tu URL de API:
```env
API_BASE_URL=https://tu-api-real.com
API_TIMEOUT=30000
ENVIRONMENT=development
DEBUG_MODE=true
ENABLE_LOGGING=true
```

Ver [ENV_CONFIG.md](ENV_CONFIG.md) para más detalles.

4. **Ejecutar la aplicación**
```bash
flutter run
```

5. **Ejecutar tests**
```bash
flutter test
```

6. **Análisis de código**
```bash
flutter analyze
```

## 🧪 Testing

El proyecto incluye tests para:

### Tests Unitarios
- **Domain Layer**: Use Cases
- **Presentation Layer**: BLoCs

**Ejecutar tests:**
```bash
flutter test
```

**Cobertura de tests:**
```bash
flutter test --coverage
```

## 🔧 Configuración

### Variables de Entorno

El proyecto utiliza **flutter_dotenv** para manejar configuraciones:

```dart
// Acceder a variables
import 'package:double_v_partners_test/core/config/env_config.dart';

String apiUrl = EnvConfig.apiBaseUrl;
bool isDebug = EnvConfig.isDebugMode;
```

**Configurar:**
```bash
cp .env.example .env
# Editar .env con tus valores
```

Ver documentación completa en [ENV_CONFIG.md](ENV_CONFIG.md)

### Personalizar el tema

Editar `lib/core/theme/app_theme.dart` para cambiar colores, tipografías, etc.

## 📱 Pantallas

### 1. Splash Screen
Pantalla inicial con logo y animación de carga (3 segundos).

### 2. Lista de Usuarios (Home)
- Muestra todos los usuarios en cards
- Pull-to-refresh
- FAB para crear nuevo usuario
- Estados: loading, error, empty, loaded

### 3. Crear Usuario
- Formulario con validaciones
- Selector de fecha de nacimiento
- Gestión dinámica de múltiples direcciones
- Diálogo modal para agregar direcciones

### 4. Detalle de Usuario
- Avatar con inicial
- Información completa
- Listado de direcciones
- Fechas de creación/actualización
- Manejo de errores con retry

## 🎨 Características Técnicas

### Manejo de Errores
- `Either<Failure, Success>` de Dartz
- Clases de Failure personalizadas (ServerFailure, NetworkFailure, etc.)
- Manejo de excepciones en todas las capas
- Mensajes de error amigables para el usuario

### Estados del BLoC
```dart
- UserInitial: Estado inicial
- UserLoading: Cargando datos
- UsersLoaded: Lista de usuarios cargada
- UserLoaded: Usuario único cargado
- UserOperationSuccess: Operación exitosa
- UserError: Error con mensaje
```

### Eventos del BLoC
```dart
- LoadUsersEvent: Cargar lista
- LoadUserByIdEvent: Cargar usuario específico
- CreateUserEvent: Crear nuevo usuario
- UpdateUserEvent: Actualizar usuario
- DeleteUserEvent: Eliminar usuario
```

## 🔍 Principios SOLID Aplicados

- **S** - Single Responsibility: Cada clase tiene una única responsabilidad
- **O** - Open/Closed: Abierto para extensión, cerrado para modificación
- **L** - Liskov Substitution: Las implementaciones pueden sustituir interfaces
- **I** - Interface Segregation: Interfaces específicas por funcionalidad
- **D** - Dependency Inversion: Dependemos de abstracciones, no de concreciones

## 📝 Buenas Prácticas

- ✅ Código limpio y mantenible
- ✅ Separación de responsabilidades
- ✅ Inmutabilidad con Equatable
- ✅ Validaciones en formularios
- ✅ Manejo de estados de carga y error
- ✅ Feedback visual al usuario (SnackBars)
- ✅ Optimización de rendimiento (const constructors)
- ✅ Comentarios en código cuando es necesario
- ✅ Nombres descriptivos y significativos

## 🤝 Contribuciones

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 👤 Autor

**Jhon Zuluaga**

## 📄 Licencia

Este proyecto fue desarrollado como parte de un test técnico para Double V Partners.
