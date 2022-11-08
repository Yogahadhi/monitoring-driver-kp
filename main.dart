import 'package:flutter/material.dart';
import 'editDriver.dart';
import 'editMobil.dart';
import 'tampilData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        body: AppNav(),
      ),
    );
  }
}

/*

=====================================================
Asset Template
=====================================================

*/

/*

Template Button

Button(text, buttonAction)

parameter :
text = Text pada tombol
buttonAction = Kode yang berjalan saat tombol ditekan

 */
class Button extends StatelessWidget {
  final String text;
  final void Function() buttonAction;

  const Button({Key? key, required this.text, required this.buttonAction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          //        primary: ,
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 62, 118, 163)),
          foregroundColor:
              MaterialStateProperty.all<Color>(Color.fromARGB(255, 1, 1, 1)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return Colors.blue.withOpacity(0.50);
            if (states.contains(MaterialState.focused))
              return Colors.blue.withOpacity(0.75);
            return null;
          }),
        ),
        onPressed: buttonAction,
        child: Text(text));
  }
}

class AppNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
            text: 'Edit Driver',
            buttonAction: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditDriver()));
            }),
        Button(
            text: 'Edit Mobil',
            buttonAction: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditMobil()));
            }),
        Button(
            text: 'Tampilkan Data',
            buttonAction: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TampilData()));
            }),
      ],
    ));
  }
}
