import 'package:flutter/material.dart';

class loader extends StatefulWidget {
  const loader({super.key});

  @override
  State<loader> createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
