import 'package:flutter/material.dart';

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

class ButtonImage extends StatelessWidget {
  final void Function() buttonAction;
  final String imgDirectory;
  final double leftPad;
  final double topPad;
  final double rightPad;
  final double bottomPad;
  final double iconSize;

  const ButtonImage(
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
          ),
        ));
  }
}