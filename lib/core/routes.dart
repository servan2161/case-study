import 'package:go_router/go_router.dart';
import 'package:harry_potter/screens/client/detalis.dart';
import 'package:harry_potter/screens/client/home.dart';
import 'package:harry_potter/screens/client/login.dart';
import 'package:harry_potter/screens/client/profile.dart';
import 'package:harry_potter/screens/core/error.dart';
import 'package:harry_potter/screens/welcome.dart';
import 'package:harry_potter/screens/static/boarding.dart';
import 'package:harry_potter/services/university.dart';

// GoRouter configuration
final routes = GoRouter(
  errorBuilder: (context, state) => const error(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/welcome', builder: (context, state) => const Welcome()),
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/profile', builder: (context, state) => const profile()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/boarding', builder: (context, state) => const Boarding()),

    GoRoute(
      path: '/university-details',
      builder: (context, state) {
        final universityData = state.extra as University;

        return Detalis(university: universityData);
      },
    ),
  ],
);
