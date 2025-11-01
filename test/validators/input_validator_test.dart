import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_flavor_manager/src/validators/input_validator.dart';

void main() {
  group('InputValidator', () {
    group('validateAppName', () {
      test('accepts valid app names', () {
        final testCases = [
          'MyApp',
          'My App',
          'My App 123',
          'App123',
          'A',
          'My Super App 2',
        ];

        for (final testCase in testCases) {
          final result = InputValidator.validateAppName(testCase);
          expect(result.isValid, isTrue, reason: 'Failed for: $testCase');
          expect(result.value, testCase.trim());
        }
      });

      test('trims whitespace from valid input', () {
        final result = InputValidator.validateAppName('  MyApp  ');
        expect(result.isValid, isTrue);
        expect(result.value, 'MyApp');
      });

      test('rejects null or empty input', () {
        final result1 = InputValidator.validateAppName(null);
        expect(result1.isValid, isFalse);
        expect(result1.error, 'No app name entered');

        final result2 = InputValidator.validateAppName('');
        expect(result2.isValid, isFalse);
        expect(result2.error, 'No app name entered');

        final result3 = InputValidator.validateAppName('   ');
        expect(result3.isValid, isFalse);
        expect(result3.error, 'No app name entered');
      });

      test('rejects app names not starting with a letter', () {
        final testCases = ['123App', '_MyApp', '-App', ' 123'];

        for (final testCase in testCases) {
          final result = InputValidator.validateAppName(testCase);
          expect(result.isValid, isFalse, reason: 'Failed for: $testCase');
          expect(result.error, 'App name must start with a letter');
        }
      });

      test('rejects app names with special characters', () {
        final testCases = [
          'My@App',
          'My-App',
          'My_App',
          'My.App',
          'My!App',
          'My#App',
        ];

        for (final testCase in testCases) {
          final result = InputValidator.validateAppName(testCase);
          expect(result.isValid, isFalse, reason: 'Failed for: $testCase');
          expect(
            result.error,
            'App name can only contain letters, numbers and spaces',
          );
        }
      });
    });

    group('validateBundleId', () {
      test('accepts valid bundle IDs', () {
        final testCases = [
          'com.example.app',
          'com.example.myapp',
          'io.github.user',
          'com.company.product.feature',
          'a.b.c',
          'com.example.app123',
          'com.example.app_name',
        ];

        for (final testCase in testCases) {
          final result = InputValidator.validateBundleId(testCase);
          expect(result.isValid, isTrue, reason: 'Failed for: $testCase');
          expect(result.value, testCase);
        }
      });

      test('trims whitespace from valid input', () {
        final result = InputValidator.validateBundleId('  com.example.app  ');
        expect(result.isValid, isTrue);
        expect(result.value, 'com.example.app');
      });

      test('rejects null or empty input', () {
        final result1 = InputValidator.validateBundleId(null);
        expect(result1.isValid, isFalse);
        expect(result1.error, 'No bundle ID entered');

        final result2 = InputValidator.validateBundleId('');
        expect(result2.isValid, isFalse);
        expect(result2.error, 'No bundle ID entered');

        final result3 = InputValidator.validateBundleId('   ');
        expect(result3.isValid, isFalse);
        expect(result3.error, 'No bundle ID entered');
      });

      test('rejects invalid bundle ID formats', () {
        final testCases = [
          'com.Example.app', // uppercase
          'Com.example.app', // uppercase
          'com', // no dots
          'com.', // trailing dot
          '.com.example', // leading dot
          'com..example', // double dot
          'com.example-app', // hyphen
          'com.123example.app', // starts with number
          'com.example.', // trailing dot
          'com.example.App', // uppercase
        ];

        for (final testCase in testCases) {
          final result = InputValidator.validateBundleId(testCase);
          expect(result.isValid, isFalse, reason: 'Failed for: $testCase');
          expect(
            result.error,
            contains('Invalid bundle ID format'),
          );
        }
      });
    });

    group('validateFlavors', () {
      test('accepts valid single flavor', () {
        final result = InputValidator.validateFlavors('dev');
        expect(result.isValid, isTrue);
        expect(result.value, 'dev');
      });

      test('accepts valid multiple flavors', () {
        final result = InputValidator.validateFlavors('dev,qa,prod');
        expect(result.isValid, isTrue);
        expect(result.value, 'dev,qa,prod');
      });

      test('accepts flavors with spaces and trims them', () {
        final result = InputValidator.validateFlavors(' dev , qa , prod ');
        expect(result.isValid, isTrue);
        expect(result.value, 'dev,qa,prod');
      });

      test('accepts uppercase and converts to lowercase', () {
        final result = InputValidator.validateFlavors('DEV,QA,PROD');
        expect(result.isValid, isTrue);
        expect(result.value, 'dev,qa,prod');
      });

      test('removes empty entries', () {
        final result = InputValidator.validateFlavors('dev,,qa,,,prod');
        expect(result.isValid, isTrue);
        expect(result.value, 'dev,qa,prod');
      });

      test('rejects null or empty input', () {
        final result1 = InputValidator.validateFlavors(null);
        expect(result1.isValid, isFalse);
        expect(result1.error, 'No flavors entered');

        final result2 = InputValidator.validateFlavors('');
        expect(result2.isValid, isFalse);
        expect(result2.error, 'No flavors entered');

        final result3 = InputValidator.validateFlavors('   ');
        expect(result3.isValid, isFalse);
        expect(result3.error, 'No flavors entered');
      });

      test('rejects input without letters', () {
        final result = InputValidator.validateFlavors('123,456');
        expect(result.isValid, isFalse);
        expect(result.error, 'Flavor name must contain at least one letter');
      });

      test('rejects input with only commas and spaces', () {
        final result = InputValidator.validateFlavors(',,,   ,  ');
        expect(result.isValid, isFalse);
        expect(result.error, 'Flavor name must contain at least one letter');
      });

      test('rejects reserved keywords', () {
        final reservedKeywords = [
          'test',
          'debug',
          'release',
          'profile',
          'main',
        ];

        for (final keyword in reservedKeywords) {
          final result = InputValidator.validateFlavors(keyword);
          expect(result.isValid, isFalse, reason: 'Failed for: $keyword');
          expect(result.error, contains('Reserved flavor names'));
          expect(result.error, contains(keyword.toLowerCase()));
        }
      });

      test('rejects when reserved keywords are in list', () {
        final result = InputValidator.validateFlavors('dev,test,prod');
        expect(result.isValid, isFalse);
        expect(result.error, contains('Reserved flavor names'));
        expect(result.error, contains('test'));
      });

      test('provides suggestions for reserved keywords', () {
        final result = InputValidator.validateFlavors('test');
        expect(result.isValid, isFalse);
        expect(result.error, contains('testing/beta/staging'));
      });
    });

    test('reservedKeywords constant contains expected values', () {
      expect(InputValidator.reservedKeywords, [
        'test',
        'androidTest',
        'debug',
        'release',
        'profile',
        'main',
      ]);
    });
  });
}

