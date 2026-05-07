import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart';
import './providers/task_provider.dart';

// En lugar de: class HomeScreen extends StatelessWidget
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  // Agregamos "WidgetRef ref" aquí
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos las tareas del provider
    final tasks = ref.watch(taskProvider);

    final theme = Theme.of(context);

    if (tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Flow')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 100, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'No hay tareas aún.',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Agrega una nueva para comenzar.',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.white60),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await context.push('/create-task');
            if (!context.mounted) return;
            if (result != null) {
              ref.read(taskProvider.notifier).addTask(result as TaskModel);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tarea creada con éxito')),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Task Flow')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            tileColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (value) =>
                  ref.read(taskProvider.notifier).toggleTask(tasks[index]),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              tasks[index].title,
              style: theme.textTheme.titleMedium?.copyWith(
                decoration: tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: tasks[index].isCompleted ? Colors.white54 : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              tasks[index].date,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(255, 255, 255, 0.7),
            ),
            onTap: () async {
              final result =
                  await context.push('/details', extra: tasks[index]);
              if (!context.mounted) return;
              if (result == 'delete') {
                ref.read(taskProvider.notifier).deleteTask(tasks[index].id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tarea eliminada con éxito')),
                );
              } else if (result == true) {
                ref.read(taskProvider.notifier).toggleTask(tasks[index]);
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/create-task');
          if (!context.mounted) return;
          if (result != null) {
            ref.read(taskProvider.notifier).addTask(result as TaskModel);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tarea creada con éxito')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
