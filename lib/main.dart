import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_weather_app/app_module.dart';

void main() {
  //runApp(const MyApp());
  return runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Open Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00B0FF)),
        useMaterial3: true,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
