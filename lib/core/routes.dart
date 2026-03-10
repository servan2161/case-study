import 'package:go_router/go_router.dart';
import 'package:harry_potter/screens/client/login.dart';
import 'package:harry_potter/screens/client/profile.dart';
import 'package:harry_potter/screens/home.dart';

// GoRouter configuration
final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const login()),
    GoRoute(path: '/profile', builder: (context, state) => const profile()),
    GoRoute(path: '/profile', builder: (context, state) => const profile()),
  ],
);
