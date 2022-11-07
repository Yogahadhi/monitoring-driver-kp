import 'package:flutter/material.dart';
import 'main.dart';

class TampilData extends StatelessWidget {
  const TampilData({super.key});

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
              ],
            )
        ),
      ),
    );
  }
}