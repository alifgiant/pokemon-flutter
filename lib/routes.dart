import 'package:go_router/go_router.dart';
import 'package:pokemon/screens/detail_screen.dart';
import 'package:pokemon/screens/home_screen.dart';
import 'package:pokemon/screens/type_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => const DetailScreen(),
    ),
    GoRoute(
      path: '/type',
      builder: (context, state) => const TypeScreen(),
    ),
  ],
);
