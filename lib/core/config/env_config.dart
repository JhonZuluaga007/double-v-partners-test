import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  EnvConfig._();

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  static String get apiBaseUrl {
    return dotenv.get('API_BASE_URL', fallback: 'https://api.example.com');
  }

  static int get apiTimeout {
    final timeout = dotenv.get('API_TIMEOUT', fallback: '30000');
    return int.tryParse(timeout) ?? 30000;
  }

  static String get appName {
    return dotenv.get('APP_NAME', fallback: 'Double V Partners Test');
  }

  static String get appVersion {
    return dotenv.get('APP_VERSION', fallback: '1.0.0');
  }

  static String get environment {
    return dotenv.get('ENVIRONMENT', fallback: 'development');
  }

  static bool get isDebugMode {
    final debug = dotenv.get('DEBUG_MODE', fallback: 'false');
    return debug.toLowerCase() == 'true';
  }

  static bool get isLoggingEnabled {
    final logging = dotenv.get('ENABLE_LOGGING', fallback: 'false');
    return logging.toLowerCase() == 'true';
  }

  static bool get isDevelopment => environment == 'development';

  static bool get isStaging => environment == 'staging';

  static bool get isProduction => environment == 'production';

  static String getCustom(String key, {String fallback = ''}) {
    return dotenv.get(key, fallback: fallback);
  }

  static bool hasKey(String key) {
    return dotenv.env.containsKey(key);
  }

  static Map<String, String> getAllVariables() {
    if (!isDebugMode) {
      return {'error': 'Only available in debug mode'};
    }
    return Map.from(dotenv.env);
  }
}
