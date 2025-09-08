import 'package:flutter/material.dart';

class LevelTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;

  const LevelTopBar({super.key, this.onBack});

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
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.cyanAccent),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
