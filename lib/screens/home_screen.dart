import 'package:flutter/material.dart';
import '../widgets/floating_image.dart';
import '../widgets/story_box.dart';
import '../widgets/adventure_button.dart';
import 'outside_screen1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatingAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -15,
      end: 15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/space_outside.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingImage(
                  animation: _floatingAnimation,
                  imagePath: "assets/images/astronaut.png",
                  height: 150,
                ),
                const SizedBox(height: 20),
                StoryBox(
                  fadeAnimation: _fadeAnimation,
                  text:
                      "We’re trapped outside the spaceship! 🚀\n\n"
                      "We need to explore our surroundings and solve puzzles "
                      "to discover the code that will let us back inside.",
                ),
                const SizedBox(height: 30),
                AdventureButton(
                  label: "Start adventure",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OutsideScreen1()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
