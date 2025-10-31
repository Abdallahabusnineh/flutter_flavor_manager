#!/usr/bin/env dart

import 'package:flutter_flavor_manager/flutter_flavor_manager.dart';

/// Entry point for the Flutter Flavor  CLI tool
///
/// Run with: dart run flutter_flavor_manager.dart
/// Or: dart bin/flutter_flavor_manager.dart
Future<void> main() async {
  final command = FlavorSetupCommand();
  await command.execute();
}
