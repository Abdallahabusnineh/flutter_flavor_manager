import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_flavor_manager/src/models/setup_result.dart';

void main() {
  group('SetupResult', () {
    group('success', () {
      test('creates a successful result with default message', () {
        final result = SetupResult.success();

        expect(result.success, isTrue);
        expect(result.message, 'Operation completed successfully');
        expect(result.warnings, isEmpty);
        expect(result.data, isNull);
      });

      test('creates a successful result with custom message', () {
        final result = SetupResult.success(
          message: 'Flavors setup complete',
        );

        expect(result.success, isTrue);
        expect(result.message, 'Flavors setup complete');
        expect(result.warnings, isEmpty);
        expect(result.data, isNull);
      });

      test('creates a successful result with warnings', () {
        final result = SetupResult.success(
          message: 'Setup complete',
          warnings: ['Warning 1', 'Warning 2'],
        );

        expect(result.success, isTrue);
        expect(result.message, 'Setup complete');
        expect(result.warnings, ['Warning 1', 'Warning 2']);
        expect(result.data, isNull);
      });

      test('creates a successful result with data', () {
        final testData = {'key': 'value'};
        final result = SetupResult.success(
          message: 'Setup complete',
          data: testData,
        );

        expect(result.success, isTrue);
        expect(result.message, 'Setup complete');
        expect(result.warnings, isEmpty);
        expect(result.data, testData);
      });

      test('creates a successful result with warnings and data', () {
        final testData = ['item1', 'item2'];
        final result = SetupResult.success(
          message: 'Partial success',
          warnings: ['Some warnings'],
          data: testData,
        );

        expect(result.success, isTrue);
        expect(result.message, 'Partial success');
        expect(result.warnings, ['Some warnings']);
        expect(result.data, testData);
      });
    });

    group('failure', () {
      test('creates a failed result with message', () {
        final result = SetupResult.failure(
          message: 'Operation failed',
        );

        expect(result.success, isFalse);
        expect(result.message, 'Operation failed');
        expect(result.warnings, isEmpty);
        expect(result.data, isNull);
      });

      test('creates a failed result with warnings', () {
        final result = SetupResult.failure(
          message: 'Operation failed',
          warnings: ['Warning 1', 'Warning 2'],
        );

        expect(result.success, isFalse);
        expect(result.message, 'Operation failed');
        expect(result.warnings, ['Warning 1', 'Warning 2']);
        expect(result.data, isNull);
      });
    });

    group('toString', () {
      test('returns formatted string for success', () {
        final result = SetupResult.success(
          message: 'All done!',
          warnings: ['warning1', 'warning2'],
        );

        expect(
          result.toString(),
          'SetupResult(success: true, message: All done!, warnings: 2)',
        );
      });

      test('returns formatted string for failure', () {
        final result = SetupResult.failure(
          message: 'Failed to setup',
        );

        expect(
          result.toString(),
          'SetupResult(success: false, message: Failed to setup, warnings: 0)',
        );
      });
    });
  });
}

