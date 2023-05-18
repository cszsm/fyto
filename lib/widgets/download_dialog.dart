import 'package:flutter/material.dart';
import 'package:fyto/widgets/identifier/identifier_screen.dart';
import 'package:fyto/widgets/loader_screen.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog({super.key});

  static const question = 'Letölti most a képeket?';
  static const explanation =
      'A növényhatározó megfelelő használatához szükség van a növényeket ábrázoló képekre. Az alkalmazás ezek letöltése nélkül is használható, azonban csak a szöveges leírások lesznek olvashatók. Mivel a képek letöltése nagy adatforgalommal járhat, letöltésük Wi-Fi hálózaton ajánlott.';
  static const now = 'Letöltöm most';
  static const later = 'Később töltöm le';
  static const test = 'Letöltöm a tesztadatokat';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(question),
      content: const Text(explanation),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IdentifierScreen(),
                ),
              );
            },
            child: const Text(later)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoaderScreen(test: false),
              ),
            );
          },
          child: const Text(now),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoaderScreen(test: true),
              ),
            );
          },
          child: const Text(test),
        ),
      ],
    );
  }
}
