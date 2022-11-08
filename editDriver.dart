import 'package:flutter/material.dart';
import 'main.dart';

class EditDriver extends StatelessWidget {
  const EditDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text('Welcome to PT PLN UIKL Monitoring Driver'),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Button(text: 'very cool', buttonAction: () {})],
        )),
      ),
    );
  }
}
