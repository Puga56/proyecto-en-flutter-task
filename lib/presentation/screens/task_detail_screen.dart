import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  // Lógica para los días restantes
  String _getDaysRemaining(String dateStr) {
    try {
      final parts = dateStr.split('/');
      final target = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      final now = DateTime.now();
      final diff = DateTime(target.year, target.month, target.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;

      if (diff < 0) return "Venció hace ${diff.abs()} días";
      if (diff == 0) return "Vence hoy";
      return "Faltan $diff días";
    } catch (e) {
      return "Fecha inválida";
    }
  }

  Color _getStatusColor(String dateStr) {
    try {
      final parts = dateStr.split('/');
      final target = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      final now = DateTime.now();
      final diff = DateTime(target.year, target.month, target.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;

      if (diff < 0) return Colors.red;
      if (diff == 0) return Colors.orange;
      return Colors.green;
    } catch (e) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detalles'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(task.date, style: const TextStyle(fontSize: 16)),
                      const Spacer(),
                      Chip(
                        label: Text(_getDaysRemaining(task.date),
                            style: const TextStyle(color: Colors.white)),
                        backgroundColor: _getStatusColor(task.date),
                      )
                    ],
                  ),
                  const Divider(height: 30),
                  const Text("Descripción:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(task.description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                icon: const Icon(Icons.check),
                label: const Text("Completar Tarea"),
                onPressed: () {
                  // Devuelve TRUE para indicar que se debe borrar
                  context.pop(true);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
