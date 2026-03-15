import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/screens/core/loader.dart';
import 'package:http/http.dart' as http;
import 'package:harry_potter/services/university.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => Home();
}

class Home extends State<HomeScreen> {
  List<University> allUniversities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/Hipo/university-domains-list/master/world_universities_and_domains.json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          allUniversities = jsonData
              .map((item) => University.fromJson(item))
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 251, 251, 46),
      body: SafeArea(child: Column(children: [])),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).replace("/home");
            },
            icon: const Icon(Icons.home_filled, color: Colors.black),
          ),

          IconButton(
            onPressed: () {
              GoRouter.of(context).replace("/profile");
            },
            icon: const Icon(Icons.person_outline, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
