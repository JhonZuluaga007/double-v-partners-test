import 'package:flutter_test/flutter_test.dart';
import 'package:double_v_partners_test/core/error/failures.dart';

void main() {
  group('Failures', () {
    group('ServerFailure', () {
      test('should create ServerFailure with default message', () {
        const failure = ServerFailure('Server error occurred');

        expect(failure.message, 'Server error occurred');
        expect(failure, isA<Failure>());
      });

      test('should create ServerFailure with custom message', () {
        const failure = ServerFailure('Custom server error');

        expect(failure.message, 'Custom server error');
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        const failure1 = ServerFailure('Error message');
        const failure2 = ServerFailure('Error message');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('should support inequality', () {
        const failure1 = ServerFailure('Error message 1');
        const failure2 = ServerFailure('Error message 2');

        expect(failure1, isNot(equals(failure2)));
        expect(failure1.hashCode, isNot(equals(failure2.hashCode)));
      });
    });

    group('CacheFailure', () {
      test('should create CacheFailure with default message', () {
        const failure = CacheFailure('Cache error occurred');

        expect(failure.message, 'Cache error occurred');
        expect(failure, isA<Failure>());
      });

      test('should create CacheFailure with custom message', () {
        const failure = CacheFailure('Custom cache error');

        expect(failure.message, 'Custom cache error');
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        const failure1 = CacheFailure('Error message');
        const failure2 = CacheFailure('Error message');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('NetworkFailure', () {
      test('should create NetworkFailure with default message', () {
        const failure = NetworkFailure('Network error occurred');

        expect(failure.message, 'Network error occurred');
        expect(failure, isA<Failure>());
      });

      test('should create NetworkFailure with custom message', () {
        const failure = NetworkFailure('Custom network error');

        expect(failure.message, 'Custom network error');
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        const failure1 = NetworkFailure('Error message');
        const failure2 = NetworkFailure('Error message');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('GeneralFailure', () {
      test('should create GeneralFailure with default message', () {
        const failure = GeneralFailure('Unexpected error occurred');

        expect(failure.message, 'Unexpected error occurred');
        expect(failure, isA<Failure>());
      });

      test('should create GeneralFailure with custom message', () {
        const failure = GeneralFailure('Custom general error');

        expect(failure.message, 'Custom general error');
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        const failure1 = GeneralFailure('Error message');
        const failure2 = GeneralFailure('Error message');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('Failure base class', () {
      test('should have correct props', () {
        const failure = ServerFailure('Test message');

        expect(failure.props, ['Test message']);
      });

      test('should have correct string representation', () {
        const failure = ServerFailure('Test message');

        expect(failure.toString(), contains('Test message'));
      });

      test('should support different failure types equality', () {
        const serverFailure = ServerFailure('Error');
        const networkFailure = NetworkFailure('Error');

        expect(serverFailure, isNot(equals(networkFailure)));
        expect(serverFailure.hashCode, isNot(equals(networkFailure.hashCode)));
      });
    });
  });
}
