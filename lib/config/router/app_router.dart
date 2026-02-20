import 'package:go_router/go_router.dart';
// importamos las pantallas
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';

// Configuración de las rutas para navegar
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
        path: '/create-task', builder: (context, state) => CreateTaskScreen()),
    GoRoute(path: '/details', builder: (context, state) => TaskDetailScreen()),
  ],
);
