import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Boarding extends StatefulWidget {
  const Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/arkaplan.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              skip(),

              Expanded(
                flex: 3,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() => _currentPage = page);
                  },
                  children: [
                    image("assets/images/hzz.png"),
                    image("assets/images/sly.png"),
                    image("assets/images/gry.png"),
                  ],
                ),
              ),

              Container(
                height: 320,
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(223, 233, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dinamik Metin
                    Text(
                      _currentPage == 0
                          ? "Verified and trustable university information!"
                          : _currentPage == 1
                          ? "Find best education spots in one place.."
                          : "Countries, provinces and much more!",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 35, 44),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            _totalPages,
                            (index) =>
                                indicator(isActive: _currentPage == index),
                          ),
                        ),

                        SizedBox(
                          width: 56,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < _totalPages - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                context.go('/login');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                53,
                                106,
                                209,
                              ),
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                              elevation: 0,
                            ),

                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget image(String image) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }

  Widget indicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 6,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(255, 53, 106, 209)
            : const Color.fromARGB(255, 53, 106, 209).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class skip extends StatelessWidget {
  const skip({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            "Skip",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
