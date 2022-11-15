import 'package:flutter/material.dart';

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
              border: Border.all(color: const Color.fromARGB(255, 37, 39, 33))),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 212, 228, 230)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.blue.withOpacity(0.50);
                    }
                    if (states.contains(MaterialState.focused)) {
                      return Colors.blue.withOpacity(0.75);
                    }
                    return null;
                  }),
            ),
            onPressed: buttonAction,
            child: Text(text),
          ),
        ));
  }
}