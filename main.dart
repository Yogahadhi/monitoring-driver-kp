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
leftPad = padding kiri
topPad = padding atas
rightPad = padding kanan
bottomPad = padding bawah

 */
class Button extends StatelessWidget {
  final String text;
  final void Function() buttonAction;
  final double leftPad;
  final double topPad;
  final double rightPad;
  final double bottomPad;

//padding button
  const Button(
      {Key? key,
      required this.buttonAction,
      this.text = '',
      this.leftPad = 5,
      this.topPad = 5,
      this.rightPad = 5,
      this.bottomPad = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(leftPad, topPad, rightPad, bottomPad),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: TextButton(
            style: ButtonStyle(
              //        primary: ,
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 62, 118, 163)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 1, 1, 1)),
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
            child: Text(text)));
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
