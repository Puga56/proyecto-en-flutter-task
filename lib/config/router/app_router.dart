import 'package:go_router/go_router.dart';
// Importaciones de las pantallas desarrolladas por el equipo (Presentation Layer)
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';

// Configuración centralizada del sistema de navegación (GoRouter)
// Responsable: Echeverria Pacheco
final appRouter = GoRouter(
  // La ruta raíz '/' define que la app iniciará siempre en el HomeScreen
  initialLocation: '/',

  routes: [
    // Definición de la ruta para la pantalla de Inicio (Listado de Proyectos)
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    // Ruta para el formulario de creación de tareas (Módulo de Fregoso Alvarado)
    GoRoute(
      path: '/create-task',
      builder: (context, state) => const CreateTaskScreen(),
    ),

    // Ruta para la vista detallada y acciones de confirmación (Módulo de Dzib Puga)
    GoRoute(
      path: '/task-detail',
      builder: (context, state) => const TaskDetailScreen(),
    ),
  ],
);
