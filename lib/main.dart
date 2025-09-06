import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/outside_screen.dart';
import 'screens/panel_screen.dart';
import 'screens/inside_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/outside': (_) => const OutsideScreen(),
        '/panel': (_) => const PanelScreen(),
        '/inside': (_) => const InsideScreen(),
      },
    );
  }
}
