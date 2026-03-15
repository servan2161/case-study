import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _loginState();
}

class _loginState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("selam"))),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}

Widget _buildBottomNav(BuildContext context) {
  return BottomAppBar(
    elevation: 0,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: 36,
          onPressed: () {
            GoRouter.of(context).replace("/home");
          },
          icon: const Icon(Icons.home_filled, color: Colors.black),
        ),

        IconButton(
          iconSize: 36,
          onPressed: () {
            GoRouter.of(context).replace("/profile");
          },
          icon: const Icon(Icons.person_outline, color: Colors.black),
        ),
      ],
    ),
  );
}
