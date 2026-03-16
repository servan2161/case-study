import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/services/university.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<profile> {
  List<University> universityList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/Hipo/university-domains-list/master/world_universities_and_domains.json',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> allData = json.decode(response.body);
        setState(() {
          universityList = allData
              .take(20)
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildSearchBar(),
            _buildCountryFilters(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildUniversityList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 41, 121, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => GoRouter.of(context).go("/home"),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Detail Find",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B3E),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
          ),
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

  Widget _buildCountryFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _filterChip("Greece", true),
          const SizedBox(width: 10),
          _filterChip("Turkey", false),
          const SizedBox(width: 10),
          _filterChip("England", false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromARGB(255, 227, 242, 253)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : const Color.fromARGB(255, 245, 245, 245),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? const Color.fromARGB(255, 13, 27, 62)
              : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildUniversityList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: universityList.length,
      itemBuilder: (context, index) {
        final uni = universityList[index];

        return GestureDetector(
          onTap: () {
            context.push('/university-details', extra: uni);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        uni.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 13, 27, 62),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 77, 182, 172),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          uni.alphaTwoCode,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 77, 182, 172),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                Text(
                  uni.webPages.isNotEmpty ? uni.webPages[0] : "domain.edu",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey.shade500,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      uni.country,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
            onPressed: () => GoRouter.of(context).replace("/home"),
            icon: const Icon(Icons.home_outlined, color: Colors.black45),
          ),
          IconButton(
            iconSize: 36,
            onPressed: () => GoRouter.of(context).replace("/profile"),
            icon: const Icon(Icons.person_outline, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
