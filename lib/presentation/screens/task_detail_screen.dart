import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.calendar_month,
                            color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text(task.date,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.white70)),
                        const Spacer(),
                        Chip(
                          label: Text(_getDaysRemaining(task.date),
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: _getStatusColor(task.date),
                        )
                      ],
                    ),
                    const Divider(height: 40, color: Colors.white12),
                    Text("Descripción:",
                        style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 12),
                    Text(task.description,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: task.isCompleted
                          ? Colors.orange
                          : theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
                    label: Text(task.isCompleted
                        ? "Marcar Pendiente"
                        : "Completar Tarea"),
                    onPressed: () {
                      context.pop(true);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text("Eliminar"),
                    onPressed: () {
                      context.pop('delete');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
