library;

import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  String toString() => message ?? 'ServerException';

  @override
  List<Object?> get props => [message];
}

class CacheException extends Equatable implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  String toString() => message ?? 'CacheException';

  @override
  List<Object?> get props => [message];
}

class NetworkException extends Equatable implements Exception {
  final String? message;

  const NetworkException([this.message]);

  @override
  String toString() => message ?? 'NetworkException';

  @override
  List<Object?> get props => [message];
}

class GeneralException extends Equatable implements Exception {
  final String? message;

  const GeneralException([this.message]);

  @override
  String toString() => message ?? 'GeneralException';

  @override
  List<Object?> get props => [message];
}
