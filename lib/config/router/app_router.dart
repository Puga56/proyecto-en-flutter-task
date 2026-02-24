import 'package:go_router/go_router.dart';
// importamos las pantallas
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';

// Esta es la configuración básica del router para movernos por la app
final appRouter = GoRouter(
// Que empiece siempre en el home al abrir la app
  initialLocation: '/',
  routes: [
// La pantalla principal
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
        // Ruta para cuando queramos crear una tarea nueva
        path: '/create-task',
        builder: (context, state) => CreateTaskScreen()),
    // Ruta para ver los detalles de la tarea (luego igual hay que pasarle el ID)
    GoRoute(path: '/details', builder: (context, state) => TaskDetailScreen()),
  ],
);
