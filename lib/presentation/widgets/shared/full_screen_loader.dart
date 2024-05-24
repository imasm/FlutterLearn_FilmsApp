import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Carregant pel·lícules ...",
      "Carregant dades ...",
      "Carregant imatges ...",
      "Preperant cafè ...",
      "Això trigarà una mica ...",
      "Ja casi està ...",
      "Ara sí ...",
    ];

    return Stream<String>.periodic(const Duration(milliseconds: 1200), (x) => messages[x % messages.length])
        .take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Carregant ...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(height: 10),
          StreamBuilder(stream: getLoadingMessages(), builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            return Text(snapshot.data ?? '');
          })
        ],
      ),
    );
  }
}
