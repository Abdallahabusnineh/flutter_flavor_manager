import 'package:flutter_flavor_manager/src/models/flavor_config.dart';
import 'package:flutter_flavor_manager/src/models/project_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProjectConfig', () {
    late List<FlavorConfig> testFlavors;

    setUp(() {
      testFlavors = [
        FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        ),
        FlavorConfig(
          name: 'qa',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        ),
        FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        ),
      ];
    });

    test('creates a valid project configuration', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: testFlavors,
      );

      expect(config.appName, 'My App');
      expect(config.appFileName, 'my_app');
      expect(config.baseBundleId, 'com.example.app');
      expect(config.androidPackageName, 'com.example.app');
      expect(config.flavors, testFlavors);
      expect(config.hasExistingFlavors, isFalse);
    });

    test('creates configuration with existing flavors flag', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: testFlavors,
        hasExistingFlavors: true,
      );

      expect(config.hasExistingFlavors, isTrue);
    });

    test('packageName getter returns appFileName', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: testFlavors,
      );

      expect(config.packageName, 'my_app');
    });

    test('flavorNames returns list of flavor names', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: testFlavors,
      );

      expect(config.flavorNames, ['dev', 'qa', 'prod']);
    });

    group('hasFlavor', () {
      late ProjectConfig config;

      setUp(() {
        config = ProjectConfig(
          appName: 'My App',
          appFileName: 'my_app',
          baseBundleId: 'com.example.app',
          androidPackageName: 'com.example.app',
          flavors: testFlavors,
        );
      });

      test('returns true for existing flavor (lowercase)', () {
        expect(config.hasFlavor('dev'), isTrue);
        expect(config.hasFlavor('qa'), isTrue);
        expect(config.hasFlavor('prod'), isTrue);
      });

      test('returns true for existing flavor (case-insensitive)', () {
        expect(config.hasFlavor('DEV'), isTrue);
        expect(config.hasFlavor('Dev'), isTrue);
        expect(config.hasFlavor('PROD'), isTrue);
      });

      test('returns false for non-existing flavor', () {
        expect(config.hasFlavor('staging'), isFalse);
        expect(config.hasFlavor('beta'), isFalse);
      });
    });

    test('toString returns formatted string', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: testFlavors,
      );

      expect(config.toString(), 'ProjectConfig(My App, dev, qa, prod)');
    });

    test('handles empty flavors list', () {
      final config = ProjectConfig(
        appName: 'My App',
        appFileName: 'my_app',
        baseBundleId: 'com.example.app',
        androidPackageName: 'com.example.app',
        flavors: [],
      );

      expect(config.flavorNames, isEmpty);
      expect(config.hasFlavor('dev'), isFalse);
    });
  });
}
