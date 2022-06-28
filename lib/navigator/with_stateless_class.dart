// https://docs.flutter.dev/cookbook/navigation/navigation-basics

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator with stateless',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Navigator with stateless'),
        ),
        body: const ButtonToScreen(),
      ),
    );
  }
}

class ButtonToScreen extends StatelessWidget {
  const ButtonToScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Open popup screen'),
        onPressed: () => _goToScreen(context),
      ),
    );
  }

  void _goToScreen(context) {
    // print(context.widget.runtimeType);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('push new screen'),
              ),
              body: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back')),
              ),
            )));
  }
}
