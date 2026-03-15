import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/services/university.dart';

class Detalis extends StatefulWidget {
  final University university;

  const Detalis({super.key, required this.university});

  @override
  State<Detalis> createState() => _DetalisState();
}

class _DetalisState extends State<Detalis> {
  bool isPageSelected = true;

  @override
  Widget build(BuildContext context) {
    final String name = widget.university.name;
    final String country = widget.university.country;
    final String code = widget.university.alphaTwoCode;

    final String domain = widget.university.domains.isNotEmpty
        ? widget.university.domains.first
        : "N/A";
    final String website = widget.university.webPages.isNotEmpty
        ? widget.university.webPages.first
        : "N/A";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 10),

            _buildMainCard(name),

            const SizedBox(height: 25),

            _buildInfoRow(country, code),

            const SizedBox(height: 30),

            _buildToggleBar(),

            const SizedBox(height: 25),

            _buildDataBox("Domains", domain),
            _buildDataBox("Web Pages", website, isLink: true),
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
              color: const Color(0xFF2979FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => GoRouter.of(context).replace("/profile"),
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
                "University Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 13, 27, 61),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildMainCard(String name) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue.shade50, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 13, 27, 62),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String country, String code) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoItem(country, "Country"),
          Container(height: 40, width: 1, color: Colors.grey.shade200),
          _infoItem(code, "Alpha 2 Code"),
        ],
      ),
    );
  }

  Widget _infoItem(String top, String bottom) {
    return Column(
      children: [
        Text(
          top,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Color.fromARGB(255, 13, 27, 62),
          ),
        ),
        const SizedBox(height: 4),
        Text(bottom, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildToggleBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 247, 251),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isPageSelected = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isPageSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isPageSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "Page",
                    style: TextStyle(
                      color: isPageSelected ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isPageSelected = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isPageSelected
                      ? Colors.white
                      : const Color.fromARGB(0, 0, 0, 0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: !isPageSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "Province",
                    style: TextStyle(
                      color: !isPageSelected ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataBox(String title, String value, {bool isLink = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 13, 27, 62),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: isLink ? Colors.blue : Colors.grey.shade600,
              fontSize: 14,
              decoration: isLink
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
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
