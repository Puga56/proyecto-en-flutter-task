import 'package:go_router/go_router.dart';
// Importa tus pantallas aquí
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/create-task',
        builder: (context, state) => const CreateTaskScreen()),
    GoRoute(
        path: '/details',
        builder: (context, state) => const TaskDetailScreen()),
  ],
);
