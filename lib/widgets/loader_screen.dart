import 'package:flutter/material.dart';
import 'package:fyto/services/image_loader.dart';
import 'package:fyto/widgets/identifier/identifier_screen.dart';
import 'package:path_provider/path_provider.dart';

class LoaderScreen extends StatefulWidget {
  final bool test;

  const LoaderScreen({
    super.key,
    required this.test,
  });

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  Future<void> _downloadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final loader = ImageLoader(directory);
    await loader.download(widget.test);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IdentifierScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    _downloadImages();

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
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
