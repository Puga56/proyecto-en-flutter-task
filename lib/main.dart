import 'package:flutter/material.dart';
// Importamos la configuración del ruteador que centraliza los caminos de la app
import 'package:task_flow/config/router/app_router.dart';

// Punto de entrada principal que dispara la ejecución de la aplicación TaskFlow
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MaterialApp.router para integrar el sistema de navegación GoRouter
    return MaterialApp.router(
      // Quitamos la etiqueta de "Debug" para una presentación más limpia ante el profesor
      debugShowCheckedModeBanner: false,

      // Conectamos la configuración del ruteador (Módulo de Echeverria Pacheco)
      routerConfig: appRouter,

      // Definición de la identidad visual de la aplicación
      theme: ThemeData(
        // REQUISITO: Activación de Material 3 para componentes modernos
        useMaterial3: true,
        // Definimos el color azul como semilla para toda la paleta de la app
        colorSchemeSeed: Colors.blue,
      ),
    );
  }
}
