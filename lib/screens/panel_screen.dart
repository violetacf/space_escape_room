import 'package:flutter/material.dart';
import '../widgets/level_top_bar.dart';
import '../widgets/level_background.dart';
import 'inside_screen.dart';

class PanelScreen extends StatelessWidget {
  const PanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: LevelTopBar(
        onBack: () => Navigator.pop(context), // back to OutsideScreen4
      ),
      body: LevelBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLandscape
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/panel.png",
                          height: 200,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Flexible(
                        flex: 1,
                        child: _PanelInputContainer(
                          controller: controller,
                          onSubmit: () {
                            if (controller.text.trim().toLowerCase() ==
                                "blue10mercury20") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const InsideScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Incorrect key 🚫"),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/panel.png", height: 200),
                      const SizedBox(height: 20),
                      _PanelInputContainer(
                        controller: controller,
                        onSubmit: () {
                          if (controller.text.trim().toLowerCase() ==
                              "blue10mercury20") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const InsideScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Incorrect key 🚫")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _PanelInputContainer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const _PanelInputContainer({
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyanAccent, width: 2),
      ),
      child: Column(
        children: [
          const Text(
            "Enter the final secret key:",
            style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Key",
              hintStyle: const TextStyle(color: Colors.white38),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent.shade200),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
            onPressed: onSubmit,
            child: const Text("Access"),
          ),
        ],
      ),
    );
  }
}
