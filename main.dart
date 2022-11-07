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
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
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

  const Button({Key? key,
    required this.text,
    required this.buttonAction
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
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
              }
          ),
        ),
        onPressed: buttonAction,
        child: Text(text)
    );
  }
}

class AppNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
                text: 'tes',
                buttonAction: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditDriver())
                  );
                }),
            Button(
                text: 'turu1',
                buttonAction: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditMobil())
                  );
                }),
            Button(
                text: 'turu2',
                buttonAction: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TampilData())
                  );
                }),
          ],
        )
    );
  }
}
