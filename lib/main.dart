import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_explorer/core/dependency_injection/di.dart';
import 'package:rick_and_morty_explorer/features/characters/presentation/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  Animate.restartOnHotReload = true;
  runApp(const AppRoot());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AppRoot();
  }
}
