import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _nameState();
}

class _nameState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 106, 253, 118),
      body: SafeArea(
        child: Center(
          //MouseRegion: Fare imlecini kontrol eder
          child: MouseRegion(
            cursor: SystemMouseCursors.click, // Fare imlecini el yapar
            child: GestureDetector(
              //GestureDetector, Görsel efekt olmadan tıklamayı yakalar
              onTap: () => GoRouter.of(context).push("/boarding"),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/howgwarts.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
