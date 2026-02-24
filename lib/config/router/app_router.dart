// lib/config/router/app_router.dart
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';
import '../../models/task_model.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/create-task',
      builder: (context, state) => const CreateTaskScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        // Importante: Castear el objeto 'extra' como Task
        final task = state.extra as Task;
        return TaskDetailScreen(task: task);
      },
    ),
  ],
);
