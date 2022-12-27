import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/editDriver/editDriver.dart';
import 'globalWidgets/button.dart';
import 'ui/editMobil/editMobil.dart';
import 'ui/tampilData/tampilData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!File('assets/data/mobil.json').existsSync()) {
      File('assets/data/mobil.json').createSync();
      File('assets/data/mobil.json').writeAsStringSync('[]');
    }
    if (!File('assets/data/driver.json').existsSync()) {
      File('assets/data/driver.json').createSync();
      File('assets/data/driver.json').writeAsStringSync('[]');
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 199, 244, 222),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.green,
            centerTitle: true,
            title: const Text('Welcome to PT PLN UIKL Monitoring Driver'),
          ),
          body: Center(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: const Image(
                    height: 100,
                    width: 70,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/pln.png')),
              ),
              const AppNav(),
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

class AppNav extends StatelessWidget {
  const AppNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 142, 195, 220),
              border: Border.all(
                color: const Color.fromARGB(255, 20, 23, 24),
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
