# Double V Partners Test

Proyecto de prueba técnica desarrollado con Flutter siguiendo principios de Clean Architecture.

## Arquitectura

Este proyecto sigue los principios de **Clean Architecture** dividido en tres capas principales:

### 1. Domain Layer (Capa de Dominio)
- **Entities**: Modelos de negocio inmutables usando Equatable
- **Repositories**: Interfaces abstractas que definen contratos
- **Use Cases**: Lógica de negocio de la aplicación

### 2. Data Layer (Capa de Datos)
- **Models**: Modelos que extienden las entidades con serialización
- **Data Sources**: Remote y Local data sources
- **Repository Implementations**: Implementaciones concretas de los repositorios

### 3. Presentation Layer (Capa de Presentación)
- **BLoC**: Gestión de estado con flutter_bloc
- **Screens**: Pantallas de la aplicación
- **Widgets**: Componentes reutilizables

## Características Técnicas

- ✅ **Clean Architecture**: Separación clara de capas
- ✅ **flutter_bloc**: Gestión de estado predictible
- ✅ **get_it + injectable**: Inyección de dependencias
- ✅ **equatable**: Comparación de valores inmutables
- ✅ **go_router**: Navegación declarativa
- ✅ **dartz**: Programación funcional (Either para manejo de errores)

## Estructura de Carpetas

```
lib/
├── core/
│   ├── constants/         # Constantes de la aplicación
│   ├── errors/           # Excepciones y Failures
│   ├── navigation/       # Configuración de rutas
│   └── usecases/         # Clase base para casos de uso
├── di/                   # Inyección de dependencias
│   └── injection_container.dart
├── domain/
│   ├── entities/         # Entidades de negocio
│   ├── repositories/     # Interfaces de repositorios
│   └── usecases/         # Casos de uso
├── data/
│   ├── datasources/      # Fuentes de datos (local y remote)
│   ├── models/           # Modelos de datos
│   └── repositories/     # Implementaciones de repositorios
└── presentation/
    ├── bloc/             # BLoCs para gestión de estado
    ├── screens/          # Pantallas de la app
    └── widgets/          # Widgets reutilizables
```

## Instalación

1. Clonar el repositorio
2. Instalar dependencias:
```bash
flutter pub get
```

3. Generar código de inyección de dependencias:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Ejecutar la aplicación

```bash
flutter run
```

## Ejecutar tests

```bash
flutter test
```

## Dependencias Principales

- **flutter_bloc**: ^9.1.1
- **equatable**: ^2.0.7
- **get_it**: ^8.2.0
- **injectable**: ^2.5.2
- **go_router**: ^16.3.0
- **dartz**: ^0.10.1

## Dependencias de Desarrollo

- **build_runner**: ^2.4.9
- **injectable_generator**: ^2.6.1
- **bloc_test**: ^10.0.0
- **mocktail**: ^1.0.3
- **flutter_lints**: ^5.0.0

## Patrones Implementados

- **Repository Pattern**: Abstracción del acceso a datos
- **Dependency Injection**: Desacoplamiento de componentes
- **BLoC Pattern**: Gestión de estado reactiva
- **Use Case Pattern**: Encapsulación de lógica de negocio
- **Either Pattern**: Manejo funcional de errores

## Autor

Desarrollado como prueba técnica para Double V Partners
