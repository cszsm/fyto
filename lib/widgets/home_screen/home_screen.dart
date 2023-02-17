import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final availableHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            height: availableHeigth,
            fit: BoxFit.cover,
            color: colorScheme.tertiary.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
