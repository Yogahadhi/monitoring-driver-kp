import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(),
              Button(),
              Button(),
            ],
          )
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          primary: ,
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.blue.withOpacity(0.50);
                if (states.contains(MaterialState.focused))
                  return Colors.blue.withOpacity(0.75);
                return null;
              }
          ),
        ),
        onPressed: () {},
        child: Text('Text Button')
    );
  }
}