import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles de Tarea')),
      body: const Center(
        child: Text('Aquí verás la descripción completa de la tarea.',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
