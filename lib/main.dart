import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'main_production.dart' as production;

/// Default main method
void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // Todo replace with the development config after setting up the development config
  // Launch production config by default
  production.main();
}
