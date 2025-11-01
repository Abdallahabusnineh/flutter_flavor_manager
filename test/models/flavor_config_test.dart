import 'package:flutter_flavor_manager/src/models/flavor_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlavorConfig', () {
    test('creates a valid flavor configuration', () {
      final flavor = FlavorConfig(
        name: 'dev',
        displayName: 'MyApp',
        bundleId: 'com.example.app',
        packageName: 'com.example.app',
      );

      expect(flavor.name, 'dev');
      expect(flavor.displayName, 'MyApp');
      expect(flavor.bundleId, 'com.example.app');
      expect(flavor.packageName, 'com.example.app');
    });

    group('isProduction', () {
      test('returns true for prod flavor', () {
        final flavor = FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(flavor.isProduction, isTrue);
      });

      test('returns false for non-prod flavors', () {
        final devFlavor = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        final qaFlavor = FlavorConfig(
          name: 'qa',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(devFlavor.isProduction, isFalse);
        expect(qaFlavor.isProduction, isFalse);
      });
    });

    group('bundleIdSuffix', () {
      test('returns empty string for production flavor', () {
        final flavor = FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(flavor.bundleIdSuffix, isEmpty);
      });

      test('returns suffix for non-production flavors', () {
        final devFlavor = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(devFlavor.bundleIdSuffix, '.dev');
      });
    });

    group('fullBundleId', () {
      test('returns base bundle ID for production flavor', () {
        final flavor = FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(flavor.fullBundleId, 'com.example.app');
      });

      test('returns bundle ID with suffix for non-production flavors', () {
        final devFlavor = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(devFlavor.fullBundleId, 'com.example.app.dev');
      });
    });

    group('fullDisplayName', () {
      test('returns display name without suffix for production', () {
        final flavor = FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(flavor.fullDisplayName, 'MyApp');
      });

      test('returns display name with uppercase suffix for non-production', () {
        final devFlavor = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(devFlavor.fullDisplayName, 'MyApp DEV');
      });
    });

    group('equality and hashCode', () {
      test('two flavors with same name are equal', () {
        final flavor1 = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        final flavor2 = FlavorConfig(
          name: 'dev',
          displayName: 'DifferentApp',
          bundleId: 'com.different.app',
          packageName: 'com.different.app',
        );

        expect(flavor1, equals(flavor2));
        expect(flavor1.hashCode, equals(flavor2.hashCode));
      });

      test('two flavors with different names are not equal', () {
        final flavor1 = FlavorConfig(
          name: 'dev',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        final flavor2 = FlavorConfig(
          name: 'prod',
          displayName: 'MyApp',
          bundleId: 'com.example.app',
          packageName: 'com.example.app',
        );

        expect(flavor1, isNot(equals(flavor2)));
      });
    });

    test('toString returns formatted string', () {
      final flavor = FlavorConfig(
        name: 'dev',
        displayName: 'MyApp',
        bundleId: 'com.example.app',
        packageName: 'com.example.app',
      );

      expect(flavor.toString(), 'FlavorConfig(dev)');
    });
  });
}
