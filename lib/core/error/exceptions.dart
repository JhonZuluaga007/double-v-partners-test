/// Excepciones personalizadas de la aplicación
library;

/// Excepción lanzada cuando hay un error del servidor
class ServerException implements Exception {
  final String? message;

  ServerException([this.message]);

  @override
  String toString() => message ?? 'ServerException';
}

/// Excepción lanzada cuando hay un error de caché
class CacheException implements Exception {
  final String? message;

  CacheException([this.message]);

  @override
  String toString() => message ?? 'CacheException';
}

/// Excepción lanzada cuando hay un error de red
class NetworkException implements Exception {
  final String? message;

  NetworkException([this.message]);

  @override
  String toString() => message ?? 'NetworkException';
}
