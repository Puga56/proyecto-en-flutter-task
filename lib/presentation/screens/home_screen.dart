import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 1. PONES LA FUNCIÓN AQUÍ (Antes del build)
  void _mostrarDialogoEliminar(BuildContext context, String nombreTarea) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar tarea?'),
        content: Text(
            'Estás por borrar "$nombreTarea". Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade800),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('La tarea se eliminó correctamente')),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('TaskFlow - Equipo 2'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final nombreTarea = 'Tarea del Proyecto ${index + 1}';
          return Card(
            child: ListTile(
              leading: Icon(Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(nombreTarea),
              subtitle: const Text('Revisión: 4 de Marzo'),
              // 2. LLAMAS A LA FUNCIÓN AQUÍ EN EL BOTÓN DE BASURA
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _mostrarDialogoEliminar(context, nombreTarea),
              ),
              onTap: () => context.push('/details'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/create-task'),
        label: const Text('Nueva Tarea'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
