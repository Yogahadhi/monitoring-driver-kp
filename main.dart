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
          backgroundColor: Color.fromARGB(255, 173, 234, 180),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.green,
            centerTitle: true,
            title: Text('Welcome to PT PLN UIKL Monitoring Driver'),
          ),
          body: Center(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  20,
                ),
                child: Image(
                    height: 80,
                    width: 50,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/pln.png')),
              ),
              AppNav(),
            ],
          ))),
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

Button(text, *buttonAction, leftPad, topPad, rightPad, bottomPad)

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
    return Padding(
        padding: EdgeInsets.fromLTRB(leftPad, topPad, rightPad, bottomPad),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 37, 39, 33))),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 212, 228, 230)),
              //        primary: ,
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Color.fromARGB(255, 2, 19, 34).withOpacity(0.50);
                if (states.contains(MaterialState.focused))
                  return Color.fromARGB(255, 10, 61, 104).withOpacity(0.75);
                return null;
              }),
            ),
            onPressed: buttonAction,
            child: Text(text),
          ),
        ));
  }
}

/*

Template ButtonIcon

ButtonIcon(*imgDirectory, *buttonAction, iconSize, leftPad, topPad, rightPad, bottomPad)

parameter :
imgDirectory = Direktori file image untuk icon
iconSize = ukuran icon
buttonAction = Kode yang berjalan saat tombol ditekan
leftPad = padding kiri
topPad = padding atas
rightPad = padding kanan
bottomPad = padding bawah

 */

class ButtonIcon extends StatelessWidget {
  final void Function() buttonAction;
  final String imgDirectory;
  final double leftPad;
  final double topPad;
  final double rightPad;
  final double bottomPad;
  final double iconSize;

  const ButtonIcon(
      {Key? key,
      required this.buttonAction,
      required this.imgDirectory,
      this.leftPad = 5,
      this.topPad = 5,
      this.rightPad = 5,
      this.bottomPad = 5,
      this.iconSize = 50})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(leftPad, topPad, rightPad, bottomPad),
        child: Container(
          child: IconButton(
            icon: Image.asset(imgDirectory),
            iconSize: iconSize,
            style: ButtonStyle(
              //        primary: ,
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
          ),
        ));
  }
}

class AppNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 142, 195, 220),
              border: Border.all(
                color: Color.fromARGB(255, 20, 23, 24),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    text: 'Edit Driver',
                    buttonAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditDriver()));
                    }),
                Button(
                    text: 'Edit Mobil',
                    buttonAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditMobil()));
                    }),
                Button(
                    text: 'Tampilkan Data',
                    buttonAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TampilData()));
                    }),
              ],
            ))));
  }
}
