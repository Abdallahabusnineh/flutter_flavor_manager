import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_flavor_manager/src/utils/string_utils.dart';

void main() {
  group('StringUtils', () {
    group('toSnakeCase', () {
      test('converts camelCase to snake_case', () {
        expect(StringUtils.toSnakeCase('myApp'), 'my_app');
        expect(StringUtils.toSnakeCase('myAwesomeApp'), 'my_awesome_app');
        expect(StringUtils.toSnakeCase('userName'), 'user_name');
      });

      test('converts PascalCase to snake_case', () {
        expect(StringUtils.toSnakeCase('MyApp'), 'my_app');
        expect(StringUtils.toSnakeCase('MyAwesomeApp'), 'my_awesome_app');
        expect(StringUtils.toSnakeCase('UserName'), 'user_name');
      });

      test('handles spaces correctly', () {
        expect(StringUtils.toSnakeCase('My App'), 'my_app');
        expect(StringUtils.toSnakeCase('My Awesome App'), 'my_awesome_app');
        expect(StringUtils.toSnakeCase('User Name'), 'user_name');
      });

      test('handles special characters', () {
        expect(StringUtils.toSnakeCase('My-App'), 'my_app');
        expect(StringUtils.toSnakeCase('My.App'), 'my_app');
        expect(StringUtils.toSnakeCase('My@App'), 'my_app');
        expect(StringUtils.toSnakeCase('My#App!'), 'my_app');
      });

      test('handles multiple consecutive special characters', () {
        expect(StringUtils.toSnakeCase('My---App'), 'my_app');
        expect(StringUtils.toSnakeCase('My   App'), 'my_app');
        expect(StringUtils.toSnakeCase('My...App'), 'my_app');
      });

      test('removes leading and trailing underscores', () {
        expect(StringUtils.toSnakeCase('_MyApp'), 'my_app');
        expect(StringUtils.toSnakeCase('MyApp_'), 'my_app');
        expect(StringUtils.toSnakeCase('_MyApp_'), 'my_app');
      });

      test('handles already snake_case strings', () {
        expect(StringUtils.toSnakeCase('my_app'), 'my_app');
        expect(StringUtils.toSnakeCase('user_name'), 'user_name');
      });

      test('handles single words', () {
        expect(StringUtils.toSnakeCase('app'), 'app');
        expect(StringUtils.toSnakeCase('App'), 'app');
        expect(StringUtils.toSnakeCase('APP'), 'app');
      });

      test('handles numbers', () {
        expect(StringUtils.toSnakeCase('MyApp123'), 'my_app123');
        expect(StringUtils.toSnakeCase('App2Test'), 'app2test');
        expect(StringUtils.toSnakeCase('123App'), '123app');
      });

      test('handles empty string', () {
        expect(StringUtils.toSnakeCase(''), '');
      });
    });

    group('toTitleCase', () {
      test('converts lowercase to Title Case', () {
        expect(StringUtils.toTitleCase('my app'), 'My App');
        expect(StringUtils.toTitleCase('user name'), 'User Name');
      });

      test('converts UPPERCASE to Title Case', () {
        expect(StringUtils.toTitleCase('MY APP'), 'My App');
        expect(StringUtils.toTitleCase('USER NAME'), 'User Name');
      });

      test('converts camelCase to Title Case', () {
        expect(StringUtils.toTitleCase('myApp'), 'My App');
        expect(StringUtils.toTitleCase('myAwesomeApp'), 'My Awesome App');
        expect(StringUtils.toTitleCase('userName'), 'User Name');
      });

      test('converts PascalCase to Title Case', () {
        expect(StringUtils.toTitleCase('MyApp'), 'My App');
        expect(StringUtils.toTitleCase('MyAwesomeApp'), 'My Awesome App');
        expect(StringUtils.toTitleCase('UserName'), 'User Name');
      });

      test('handles snake_case', () {
        expect(StringUtils.toTitleCase('my_app'), 'My_app');
        expect(StringUtils.toTitleCase('user_name'), 'User_name');
      });

      test('handles already Title Case strings', () {
        expect(StringUtils.toTitleCase('My App'), 'My App');
        expect(StringUtils.toTitleCase('User Name'), 'User Name');
      });

      test('handles single words', () {
        expect(StringUtils.toTitleCase('app'), 'App');
        expect(StringUtils.toTitleCase('APP'), 'App');
        expect(StringUtils.toTitleCase('App'), 'App');
      });

      test('handles multiple spaces', () {
        expect(StringUtils.toTitleCase('my  app'), 'My  App');
        expect(StringUtils.toTitleCase('my   awesome   app'), 'My   Awesome   App');
      });

      test('handles empty string', () {
        expect(StringUtils.toTitleCase(''), '');
      });

      test('handles numbers', () {
        expect(StringUtils.toTitleCase('my app 123'), 'My App 123');
        expect(StringUtils.toTitleCase('app2test'), 'App2test');
      });
    });

    group('generateXcodeId', () {
      test('generates 24-character hex string', () {
        final id = StringUtils.generateXcodeId(0);
        expect(id.length, 24);
        expect(RegExp(r'^[0-9A-F]+$').hasMatch(id), isTrue);
      });

      test('generates different IDs for different counters', () {
        final id1 = StringUtils.generateXcodeId(0);
        final id2 = StringUtils.generateXcodeId(1);
        final id3 = StringUtils.generateXcodeId(100);

        expect(id1, isNot(equals(id2)));
        expect(id2, isNot(equals(id3)));
        expect(id1, isNot(equals(id3)));
      });

      test('generates IDs with correct padding', () {
        final id = StringUtils.generateXcodeId(0);
        // Should start with zeros for padding
        expect(id.length, 24);
        // All characters should be uppercase hex
        expect(RegExp(r'^[0-9A-F]{24}$').hasMatch(id), isTrue);
      });

      test('handles large counter values', () {
        final id = StringUtils.generateXcodeId(999999);
        expect(id.length, 24);
        expect(RegExp(r'^[0-9A-F]+$').hasMatch(id), isTrue);
      });

      test('handles negative counter values', () {
        // The implementation will still work with negative values
        // as they will be added to timestamp
        final id = StringUtils.generateXcodeId(-100);
        expect(id.length, 24);
        expect(RegExp(r'^[0-9A-F]+$').hasMatch(id), isTrue);
      });
    });
  });
}

