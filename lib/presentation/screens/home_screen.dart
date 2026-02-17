import 'package:flutter/material.dart';
// Importamos la extensión de GoRouter para habilitar el context.push
import 'package:go_router/go_router.dart';

// Pantalla principal del proyecto TaskFlow
// Responsable: Dzul Ortega
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con el nombre de la aplicación
      appBar: AppBar(title: const Text('TaskFlow - Mis Tareas')),

      // ListView: Widget fundamental para mostrar colecciones de datos (requisito de UI)
      body: ListView(
        children: [
          // ListTile: Componente pre-diseñado ideal para mostrar ítems de una lista
          ListTile(
            title: const Text('Completar diseño de UI'),
            subtitle: const Text(
              'Fecha: 4 de Marzo',
            ), // Referencia a la fecha de entrega
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ), // Icono indicador de acción
            // Uso de GoRouter para navegar a la pantalla de detalles de Dzib Puga
            onTap: () => context.push('/task-detail'),
          ),

          ListTile(
            title: const Text('Configurar GoRouter'),
            subtitle: const Text('Estado: Terminado'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.push('/task-detail'),
          ),
        ],
      ),

      // Botón flotante para la creación de nuevas tareas (Acción Principal)
      floatingActionButton: FloatingActionButton(
        // Navegación hacia la pantalla de creación de Fregoso Alvarado
        onPressed: () => context.push('/create-task'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
