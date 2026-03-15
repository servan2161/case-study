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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildTopBar(),
              const SizedBox(height: 30),
              _buildSearchBar(),
              const SizedBox(height: 30),
              _buildSectionHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? const loader()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemCount: allUniversities.length > 40
                            ? 40
                            : allUniversities.length,
                        itemBuilder: (context, index) {
                          final university = allUniversities[index];
                          return _buildCountryCard(university);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/welcome');
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 53, 106, 209),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.logout, color: Colors.white, size: 20),
          ),
        ),
        const Text(
          "Finder",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search Country",
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 33, 150, 243),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Countries",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 240, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Detail Searching",
            style: TextStyle(
              color: Color.fromARGB(255, 53, 106, 209),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCard(University uni) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromARGB(29, 158, 158, 158)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 28, 182, 182),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                uni.alphaTwoCode,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          uni.country,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 158, 158, 158),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
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
}
