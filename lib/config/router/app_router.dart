import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/create_task_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';
import '../../models/task_model.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
// La pantalla principal
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
        path: '/create-task', builder: (context, state) => CreateTaskScreen()),
    GoRoute(
        path: '/details',
        builder: (context, state) =>
            TaskDetailScreen(task: state.extra as TaskModel)),
  ],
);
