import 'package:flutter/material.dart';
import '../widgets/floating_image.dart';
import '../widgets/futuristic_dialog.dart';
import 'outside_screen1.dart';
import 'outside_screen2.dart';
import 'outside_screen3.dart';
import 'outside_screen4.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatingAnimation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAdventure() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OutsideScreen1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isLandscape
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: FloatingImage(
                            animation: _floatingAnimation,
                            imagePath: 'assets/images/astronaut.png',
                            height: 150,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Flexible(
                          flex: 2,
                          child: FuturisticDialog(
                            type: LevelDialogType.intro,
                            title: 'Outside the spaceship',
                            message:
                                "We’re trapped outside the spaceship! 🚀\n\n"
                                "We need to explore our surroundings and solve puzzles "
                                "to discover the code that will let us back inside.",
                            actions: [
                              TextButton(
                                onPressed: _startAdventure,
                                child: const Text('Start adventure'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingImage(
                          animation: _floatingAnimation,
                          imagePath: 'assets/images/astronaut.png',
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        FuturisticDialog(
                          type: LevelDialogType.intro,
                          title: 'Outside the spaceship',
                          message:
                              "We’re trapped outside the spaceship! 🚀\n\n"
                              "We need to explore our surroundings and solve puzzles "
                              "to discover the code that will let us back inside.",
                          actions: [
                            TextButton(
                              onPressed: _startAdventure,
                              child: const Text('Start adventure'),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
          // TODO: DELETE Debug dropdown para navegar entre niveles
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: PopupMenuButton<int>(
          //     icon: const Icon(Icons.settings, color: Colors.white),
          //     onSelected: (level) {
          //       Widget targetScreen;
          //       switch (level) {
          //         case 1:
          //           targetScreen = const OutsideScreen1();
          //           break;
          //         case 2:
          //           targetScreen = const OutsideScreen2();
          //           break;
          //         case 3:
          //           targetScreen = const OutsideScreen3();
          //           break;
          //         case 4:
          //           targetScreen = const OutsideScreen4();
          //           break;
          //         default:
          //           targetScreen = const OutsideScreen1();
          //       }
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(builder: (_) => targetScreen),
          //       );
          //     },
          //     itemBuilder: (_) => const [
          //       PopupMenuItem(value: 1, child: Text("Level 1")),
          //       PopupMenuItem(value: 2, child: Text("Level 2")),
          //       PopupMenuItem(value: 3, child: Text("Level 3")),
          //       PopupMenuItem(value: 4, child: Text("Level 4")),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
