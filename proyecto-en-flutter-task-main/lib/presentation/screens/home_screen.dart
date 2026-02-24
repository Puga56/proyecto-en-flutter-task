import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart'; // Asegúrate que esta ruta sea correcta

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Cargar tareas guardadas
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksData = prefs.getString('tasks_list');
    if (tasksData != null) {
      final List<dynamic> decodedData = jsonDecode(tasksData);
      setState(() {
        tasks = decodedData.map((item) => Task.fromMap(item)).toList();
      });
    }
  }

  // Guardar tareas en el celular
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString('tasks_list', encodedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: tasks.isEmpty 
        ? Center(
            child: Text('No hay tareas pendientes', 
              style: TextStyle(fontSize: 18, color: Colors.grey[600]))
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.indigo),
                  title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Entrega: ${task.date}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      setState(() => tasks.removeAt(index));
                      _saveTasks();
                    },
                  ),
                  onTap: () async {
                    // AQUÍ ESTÁ LA MAGIA: Esperamos el resultado de "Detalles"
                    final result = await context.push('/details', extra: task);
                    
                    // Si result es true, significa "Completar Tarea"
                    if (result == true) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                      _saveTasks();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Tarea completada!'), backgroundColor: Colors.green)
                        );
                      }
                    }
                  },
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Nueva Tarea', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          // Esperamos a que se cree la tarea
          final result = await context.push('/create-task');
          if (result != null && result is Task) {
            setState(() => tasks.add(result));
            _saveTasks();
          }
        },
      ),
    );
  }
}