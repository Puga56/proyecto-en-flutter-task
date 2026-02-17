import 'package:flutter/material.dart';

// Pantalla de visualización detallada de tareas
// Responsable: Dzib Puga
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Título descriptivo de la vista de detalle
      appBar: AppBar(title: const Text('Detalle de Tarea')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto estático que representa la información de la tarea seleccionada
            const Text(
              'Tarea: Terminar Avance 1',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            // Botón de acción crítica (Eliminar) con estilo visual de advertencia
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // Uso de un tono rojizo para indicar una acción destructiva/crítica
                backgroundColor: Colors.red.shade100,
              ),
              onPressed: () {
                // REQUISITO TÉCNICO: Implementación de Diálogo de Confirmación
                // Garantiza que el usuario no realice acciones irreversibles por accidente
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Eliminar tarea?'),
                    actions: [
                      // Opción para cancelar la acción y cerrar el diálogo
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      // Opción para confirmar la acción (simulada por ahora)
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Sí'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Eliminar Tarea',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
