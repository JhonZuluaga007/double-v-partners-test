/// Constantes de la aplicación
class AppConstants {
  // Evitar instanciación
  AppConstants._();

  // Configuración de la app
  static const String appName = 'Double V Partners Test';
  static const String appVersion = '1.0.0';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Mensajes de error
  static const String serverErrorMessage = 'Error del servidor';
  static const String networkErrorMessage = 'Error de conexión';
  static const String cacheErrorMessage = 'Error al cargar datos locales';
  static const String unknownErrorMessage = 'Error desconocido';
}
