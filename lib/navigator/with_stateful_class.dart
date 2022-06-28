import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator with stateful',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Navigator with stateful'),
        ),
        body: const ButtonToScreen(),
      ),
    );
  }
}

class ButtonToScreen extends StatefulWidget {
  const ButtonToScreen({Key? key}) : super(key: key);

  @override
  State<ButtonToScreen> createState() => _ButtonToScreenState();
}

class _ButtonToScreenState extends State<ButtonToScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        // onPressed: ()=>_goToScreen(context),
        onPressed: _goToScreen,
        child: const Text('Open popup screen'),
      ),
    );
  }

  void _goToScreen() {
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

// void _goToScreen(context) {
//   // print(context.widget.runtimeType);
//   Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => Scaffold(
//             appBar: AppBar(
//               title: const Text('push new screen'),
//             ),
//             body: Center(
//               child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Go Back')),
//             ),
//           )));
// }
