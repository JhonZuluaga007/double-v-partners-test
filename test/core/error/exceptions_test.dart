import 'package:flutter_test/flutter_test.dart';
import 'package:double_v_partners_test/core/error/exceptions.dart';

void main() {
  group('Exceptions', () {
    group('ServerException', () {
      test('should create ServerException with default message', () {
        final exception = ServerException('Server error occurred');

        expect(exception.message, 'Server error occurred');
        expect(exception, isA<ServerException>());
      });

      test('should create ServerException with custom message', () {
        final exception = ServerException('Custom server error');

        expect(exception.message, 'Custom server error');
        expect(exception, isA<ServerException>());
      });

      test('should support equality', () {
        final exception1 = ServerException('Error message');
        final exception2 = ServerException('Error message');

        expect(exception1, equals(exception2));
        expect(exception1.hashCode, equals(exception2.hashCode));
      });

      test('should support inequality', () {
        final exception1 = ServerException('Error message 1');
        final exception2 = ServerException('Error message 2');

        expect(exception1, isNot(equals(exception2)));
        expect(exception1.hashCode, isNot(equals(exception2.hashCode)));
      });
    });

    group('CacheException', () {
      test('should create CacheException with default message', () {
        final exception = CacheException('Cache error occurred');

        expect(exception.message, 'Cache error occurred');
        expect(exception, isA<CacheException>());
      });

      test('should create CacheException with custom message', () {
        final exception = CacheException('Custom cache error');

        expect(exception.message, 'Custom cache error');
        expect(exception, isA<CacheException>());
      });

      test('should support equality', () {
        final exception1 = CacheException('Error message');
        final exception2 = CacheException('Error message');

        expect(exception1, equals(exception2));
        expect(exception1.hashCode, equals(exception2.hashCode));
      });
    });

    group('NetworkException', () {
      test('should create NetworkException with default message', () {
        final exception = NetworkException('Network error occurred');

        expect(exception.message, 'Network error occurred');
        expect(exception, isA<NetworkException>());
      });

      test('should create NetworkException with custom message', () {
        final exception = NetworkException('Custom network error');

        expect(exception.message, 'Custom network error');
        expect(exception, isA<NetworkException>());
      });

      test('should support equality', () {
        final exception1 = NetworkException('Error message');
        final exception2 = NetworkException('Error message');

        expect(exception1, equals(exception2));
        expect(exception1.hashCode, equals(exception2.hashCode));
      });
    });

    group('GeneralException', () {
      test('should create GeneralException with default message', () {
        final exception = GeneralException('Unexpected error occurred');

        expect(exception.message, 'Unexpected error occurred');
        expect(exception, isA<GeneralException>());
      });

      test('should create GeneralException with custom message', () {
        final exception = GeneralException('Custom general error');

        expect(exception.message, 'Custom general error');
        expect(exception, isA<GeneralException>());
      });

      test('should support equality', () {
        final exception1 = GeneralException('Error message');
        final exception2 = GeneralException('Error message');

        expect(exception1, equals(exception2));
        expect(exception1.hashCode, equals(exception2.hashCode));
      });
    });

    group('Exception base class', () {
      test('should have correct string representation', () {
        final exception = ServerException('Test message');

        expect(exception.toString(), contains('Test message'));
      });

      test('should support different exception types equality', () {
        final serverException = ServerException('Error');
        final networkException = NetworkException('Error');

        expect(serverException, isNot(equals(networkException)));
        expect(
          serverException.hashCode,
          isNot(equals(networkException.hashCode)),
        );
      });
    });
  });
}
