import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/core/storage.dart';

class loader extends StatefulWidget {
  const loader({super.key});

  @override
  State<loader> createState() => _loaderState();
}

class _loaderState extends State<loader> {
  Future<void> loadapp() async {
    final storage = Storage();
    final first = await storage.first();
    if (first) {
      GoRouter.of(context).replace("/home");
    } else {
      GoRouter.of(context).replace("/loader");
    }
  }

  @override
  void initState() {
    super.initState();
    loadapp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
