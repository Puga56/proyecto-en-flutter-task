import 'package:flutter/material.dart';

// Pantalla para la creación de nuevas tareas en TaskFlow
// Responsable: Fregoso Alvarado
class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar configurada con CamelCase para seguir el estándar de Flutter
      appBar: AppBar(title: const Text('Nueva Tarea - TaskFlow')),

      body: Padding(
        // Padding de 20.0 para dar aire y legibilidad a los elementos del formulario
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextFormField: Widget para la entrada de texto del usuario
            // Nota: Se eliminó el 'const' porque este widget es dinámico al recibir texto
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre de la tarea',
                border:
                    OutlineInputBorder(), // Estilo de borde moderno (Material 3)
              ),
            ),
            const SizedBox(height: 20), // Espaciador constante entre campos
            // Segundo campo de entrada para asignar un responsable al proyecto
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Responsable (Integrante)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Botón de acción para procesar la información ingresada
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                  50,
                ), // Botón que abarca todo el ancho
              ),
              onPressed: () {
                // REQUISITO: Uso de showDialog para retroalimentación al usuario
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Tarea Guardada'),
                    content: const Text('La tarea se ha creado localmente.'),
                    actions: [
                      // Botón para cerrar el diálogo y limpiar el flujo de navegación
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Guardar Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
