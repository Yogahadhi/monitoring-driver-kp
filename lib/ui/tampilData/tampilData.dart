import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../main.dart';
import '../editDriver/editDriver.dart';
import '../editMobil/editMobil.dart';

class TampilData extends StatelessWidget {
  const TampilData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Monitoring Driver App',
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Menu Menampilkan Data'),
        ),
        drawer: Drawer(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.bottomLeft,
              child: const Text(
                "Menu Pilihan",
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 20,
                    color: Color.fromARGB(255, 223, 239, 212)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              leading: const Icon(
                Icons.home,
                size: 33,
              ),
              title: const Text(
                'Menu Utama',
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 15,
                    color: Color.fromARGB(255, 16, 16, 15)),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EditMobil()));
              },
              leading: const Icon(
                Icons.airport_shuttle,
                size: 33,
              ),
              title: const Text(
                'Edit Mobil',
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 15,
                    color: Color.fromARGB(255, 16, 16, 15)),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDriver()));
              },
              leading: const Icon(
                Icons.person,
                size: 33,
              ),
              title: const Text(
                'Edit Driver',
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 15,
                    color: Color.fromARGB(255, 16, 16, 15)),
              ),
            ),
          ]),
        ),
        body: Container(),
      ),
    );
  }
}
