# Double V Partners - Technical Test Flutter

A mobile application developed in Flutter following **Clean Architecture** with **Feature-First** organization and **flutter_bloc** for state management.

## 📋 Features

- ✅ **Clean Architecture** with separation into layers: Domain, Data, and Presentation
- ✅ **Feature-First Organization** for better scalability
- ✅ **State Management** with flutter_bloc
- ✅ **Dependency Injection** with GetIt
- ✅ **Navigation** with GoRouter
- ✅ **REST API Consumption** with Dio
- ✅ **Functional Error Handling** with Dartz (Either<Failure, Success>)
- ✅ **Unit Testing** with mocktail and bloc_test
- ✅ **Geographic Data Management** with nested dropdowns
- ✅ **Environment Variables Management** with flutter_dotenv

## 🎯 Functionalities

### 1. Users List
- Display all users in cards
- Pull-to-refresh to update the list
- Navigation to user details
- Loading and error state handling

### 2. Create User
- Complete form with validations:
  - Name (required)
  - Last name (required)
  - Birth date (date picker)
  - Addresses (multiple, with country, department, and municipality)
- Dynamic add/remove addresses
- Real-time validations
- Loading indicators during creation

### 3. User Details
- Complete user information
- Avatar with name initials
- Formatted birth date
- List of all addresses
- Creation and update dates
- Error handling with retry option

### 4. Geographic Address Selection
- **Nested Dropdowns**: Country → Department → Municipality
- **Reactive State Management** with AddressFormBloc
- **JSON-based Data Source** from assets
- **Generic Dropdown Component** for reusability
- **Clean Architecture Implementation** for geographic data

## 🏗️ Architecture

```
lib/
├── core/                          # Shared/common code
│   ├── config/                    # Environment configuration
│   ├── error/                     # Exceptions and Failures
│   ├── navigation/                # Routes (GoRouter)
│   ├── network/                   # HTTP Client (Dio)
│   ├── theme/                     # App themes
│   └── widgets/                   # Reusable widgets
│
├── features/                      # Features (Feature-First)
│   └── users/                     # Users feature
│       ├── data/                  # Data Layer
│       │   ├── datasources/       # Remote & Local data sources
│       │   ├── models/            # JSON serialization models
│       │   └── repositories/      # Repository implementations
│       │
│       ├── domain/                # Domain Layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Use cases
│       │
│       └── presentation/          # Presentation Layer
│           ├── bloc/              # BLoC (State)
│           ├── pages/             # Screens
│           └── widgets/           # Reusable widgets
│
├── di/                            # Dependency injection (GetIt)
└── main.dart                      # Entry point
```

## 📦 Main Dependencies

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
  intl: ^0.20.2

  # Environment Variables
  flutter_dotenv: ^5.1.0

dev_dependencies:
  # Testing
  bloc_test: ^10.0.0
  mocktail: ^1.0.3
  
  # Code Generation
  build_runner: ^2.4.6
  freezed: ^2.4.5
```

## 🔌 API Endpoints

### POST /api/users
Creates a new user.

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
Gets the list of all users.

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
Gets a specific user by ID.

## 🌍 Geographic Data Implementation

### JSON Structure
The geographic data is stored in `assets/geo_data.json` with the following structure:

```json
[
  {
    "name": "Colombia",
    "iso2": "CO",
    "phone_code": "57",
    "states": [
      {
        "name": "Antioquia",
        "cities": [
          {
            "name": "Medellín"
          },
          {
            "name": "Bello"
          }
        ]
      }
    ]
  }
]
```

### Implementation Features
- **Reactive State Management**: AddressFormBloc manages the state of nested dropdowns
- **Generic Dropdown Component**: Reusable component for all geographic selections
- **Clean Architecture**: Proper separation of concerns with entities, models, and data sources
- **Caching**: Geographic data is cached after first load for better performance
- **Error Handling**: Comprehensive error handling for data loading failures

### Components
- `GenericDropdown<T>`: Reusable dropdown component
- `CountryDropdown`: Specific implementation for country selection
- `StateDropdown`: Specific implementation for state/department selection
- `CityDropdown`: Specific implementation for city/municipality selection
- `AddressFormBloc`: BLoC for managing geographic form state

## 🔧 Environment Variables Management

The project uses **flutter_dotenv** for environment configuration:

### Configuration
```dart
// Access variables
import 'package:double_v_partners_test/core/config/env_config.dart';

String apiUrl = EnvConfig.apiBaseUrl;
bool isDebug = EnvConfig.isDebugMode;
```

### Available Variables
- `API_BASE_URL`: Base URL for the API
- `API_TIMEOUT`: Request timeout in milliseconds
- `APP_NAME`: Application name
- `APP_VERSION`: Application version
- `ENVIRONMENT`: Environment (development/staging/production)
- `DEBUG_MODE`: Enable debug mode
- `ENABLE_LOGGING`: Enable logging

### Setup
```bash
# Create .env file with your configuration
API_BASE_URL=https://your-api-url.com
API_TIMEOUT=30000
ENVIRONMENT=development
DEBUG_MODE=true
ENABLE_LOGGING=true
```

## 🚀 Installation and Execution

### Prerequisites
- Flutter SDK >= 3.9.2
- Dart SDK >= 3.9.2

### Steps

1. **Clone the repository**
```bash
git clone <repository-url>
cd double_v_partners_test
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Environment Variables**

Create a `.env` file with your configuration:
```bash
# Copy example file (if available)
cp .env.example .env

# Or create manually
touch .env
```

Edit `.env` with your values:
```env
API_BASE_URL=https://your-api-url.com
API_TIMEOUT=30000
ENVIRONMENT=development
DEBUG_MODE=true
ENABLE_LOGGING=true
```

4. **Run the application**
```bash
flutter run
```

5. **Run tests**
```bash
flutter test
```

6. **Code analysis**
```bash
flutter analyze
```

## 🧪 Testing

The project includes comprehensive tests for:

### Test Coverage
- **Core Layer**: 70% coverage
  - Error handling (exceptions and failures)
  - Environment configuration
- **Domain Layer**: 100% coverage
  - Entities (User, Address, Country, State, City)
  - Use cases (GetUsers, GetUserById, CreateUser)
- **Data Layer**: 85% coverage
  - Models (JSON serialization/deserialization)
  - Repository implementations
  - Data sources (API and local)
- **Presentation Layer**: 100% coverage
  - BLoCs (CreateUserBloc, AddressFormBloc)

### Test Types
- **Unit Tests**: Domain logic, repositories, and BLoCs
- **Integration Tests**: Feature workflows
- **Widget Tests**: UI components

### Run Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test files
flutter test test/features/users/domain/
```

### Test Results
- **Total Tests**: 132 tests
- **Passing**: 132 tests ✅
- **Failing**: 0 tests ❌
- **Coverage**: ~85% overall

## 📱 Screens

### 1. Splash Screen
Initial screen with logo and loading animation (3 seconds).

### 2. Users List (Home)
- Shows all users in cards
- Pull-to-refresh functionality
- FAB to create new user
- States: loading, error, empty, loaded

### 3. Create User
- Form with validations
- Birth date picker
- Dynamic management of multiple addresses
- Geographic address selection with nested dropdowns

### 4. User Details
- Avatar with initials
- Complete information
- Address list
- Creation/update dates
- Error handling with retry

### 5. Address Form Screen
- **Country Selection**: Dropdown with all available countries
- **Department Selection**: Dependent on country selection
- **Municipality Selection**: Dependent on department selection
- **Confirmation Button**: Validates complete selection

## 🎨 Technical Features

### Error Handling
- `Either<Failure, Success>` from Dartz
- Custom Failure classes (ServerFailure, NetworkFailure, etc.)
- Exception handling in all layers
- User-friendly error messages

### BLoC States
```dart
- UserInitial: Initial state
- UserLoading: Loading data
- UsersLoaded: Users list loaded
- UserLoaded: Single user loaded
- UserOperationSuccess: Operation successful
- UserError: Error with message
```

### BLoC Events
```dart
- LoadUsersEvent: Load list
- LoadUserByIdEvent: Load specific user
- CreateUserEvent: Create new user
- UpdateUserEvent: Update user
- DeleteUserEvent: Delete user
```

### Geographic Form States
```dart
- AddressFormInitial: Initial state
- AddressFormLoading: Loading geographic data
- AddressFormLoaded: Data loaded successfully
- AddressFormError: Error loading data
```

## 🔍 SOLID Principles Applied

- **S** - Single Responsibility: Each class has a single responsibility
- **O** - Open/Closed: Open for extension, closed for modification
- **L** - Liskov Substitution: Implementations can substitute interfaces
- **I** - Interface Segregation: Specific interfaces per functionality
- **D** - Dependency Inversion: Depend on abstractions, not concretions

## 📝 Best Practices

- ✅ Clean and maintainable code
- ✅ Separation of responsibilities
- ✅ Immutability with Equatable
- ✅ Form validations
- ✅ Loading and error state handling
- ✅ Visual feedback to users (SnackBars)
- ✅ Performance optimization (const constructors)
- ✅ Descriptive and meaningful names
- ✅ Comprehensive test coverage
- ✅ Generic and reusable components

## 🧩 Reusable Components

### GenericDropdown<T>
A generic, reusable dropdown component that provides consistent behavior across the application:

```dart
GenericDropdown<CountryEntity>(
  label: 'Country',
  hint: 'Select your country',
  getItems: (state) => state.countries,
  getSelectedItem: (state) => state.selectedCountry,
  isEnabled: (state) => true,
  isLoading: (state) => state.isLoading,
  hasError: (state) => state.hasError,
  getErrorMessage: (state) => state.errorMessage,
  loadingMessage: 'Loading countries...',
  errorMessage: 'Error loading countries',
  getItemName: (country) => country.name,
  onItemSelected: (context, country) {
    context.read<AddressFormBloc>().add(CountrySelected(country));
  },
)
```

### ActionButton
A reusable action button component with predefined constructors:

```dart
ActionButton.create(
  onPressed: () => _submitForm(),
  isEnabled: _isFormValid,
)

ActionButton.selection(
  onPressed: () => _confirmSelection(),
  isEnabled: _isSelectionComplete,
)
```

## 🤝 Contributing

To contribute to the project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👤 Author

**Jhon Zuluaga**

## 📄 License

This project was developed as part of a technical test for Double V Partners.

## 📊 Project Statistics

- **Flutter Version**: 3.9.2+
- **Dart Version**: 3.9.2+
- **Total Files**: 47+ Dart files
- **Test Files**: 16 test files
- **Test Coverage**: ~85%
- **Architecture**: Clean Architecture with Feature-First organization
- **State Management**: flutter_bloc
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **HTTP Client**: Dio
- **Error Handling**: Dartz (Either<Failure, Success>)
- **Testing**: mocktail, bloc_test
- **Code Generation**: Freezed, build_runner

## 🚀 Performance Optimizations

- **Const Constructors**: Used throughout the application for better performance
- **Widget Reusability**: Generic components reduce code duplication
- **State Management**: Efficient BLoC implementation with proper state handling
- **Lazy Loading**: Dependencies are loaded only when needed
- **Caching**: Geographic data is cached after first load
- **Memory Management**: Proper disposal of controllers and resources

## 🔒 Security Considerations

- **Environment Variables**: Sensitive data is managed through environment variables
- **Input Validation**: All user inputs are properly validated
- **Error Handling**: Sensitive error information is not exposed to users
- **Dependency Management**: All dependencies are kept up to date

---

**Note**: This project demonstrates advanced Flutter development practices including Clean Architecture, reactive state management, comprehensive testing, and professional code organization suitable for production applications.