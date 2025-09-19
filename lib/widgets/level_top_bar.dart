import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/outside_screen1.dart';
import '/screens/outside_screen2.dart';
import '/screens/outside_screen3.dart';
import '/screens/outside_screen4.dart';

class LevelTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSummary;
  final bool showDebugMenu;

  const LevelTopBar({super.key, this.onSummary, this.showDebugMenu = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: const Border(
          bottom: BorderSide(color: Colors.cyanAccent, width: 2),
        ),
      ),
      child: Row(
        children: [
          // Summary button
          IconButton(
            icon: const Icon(Icons.list, color: Colors.cyanAccent),
            onPressed:
                onSummary ??
                () {
                  // default behavior
                },
          ),

          const Spacer(),

          // TODO: delete debug menu
          // if (showDebugMenu)
          //   PopupMenuButton<int>(
          //     icon: const Icon(Icons.settings, color: Colors.white),
          //     onSelected: (level) {
          //       Widget targetScreen;
          //       switch (level) {
          //         case 0:
          //           targetScreen = const HomeScreen();
          //           break;
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
