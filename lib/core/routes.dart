import 'package:go_router/go_router.dart';
import 'package:harry_potter/screens/client/home.dart';
import 'package:harry_potter/screens/client/login.dart';
import 'package:harry_potter/screens/client/profile.dart';
import 'package:harry_potter/screens/core/error.dart';
import 'package:harry_potter/screens/welcome.dart';
import 'package:harry_potter/screens/static/boarding.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const error(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/welcome', builder: (context, state) => const Welcome()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/profile', builder: (context, state) => const profile()),
    GoRoute(path: '/home', builder: (context, state) => const Home()),
    GoRoute(path: '/boarding', builder: (context, state) => const Boarding()),
  ],
);
