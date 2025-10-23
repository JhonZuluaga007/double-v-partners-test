import 'package:equatable/equatable.dart';

/// Clase abstracta base para representar fallos en la aplicación
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Fallo del servidor
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Fallo de caché
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Fallo de red
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Fallo general
class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}
