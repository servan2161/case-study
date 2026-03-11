import 'package:go_router/go_router.dart';
import 'package:harry_potter/screens/client/login.dart';
import 'package:harry_potter/screens/client/profile.dart';
import 'package:harry_potter/screens/core/error.dart';
import 'package:harry_potter/screens/core/loader.dart';
import 'package:harry_potter/screens/home.dart';
import 'package:harry_potter/screens/static/boarding.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const error(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const loader()),
    GoRoute(path: '/login', builder: (context, state) => const login()),
    GoRoute(path: '/profile', builder: (context, state) => const profile()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/boarding', builder: (context, state) => const Boarding()),
  ],
);
