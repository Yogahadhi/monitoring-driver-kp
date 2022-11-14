import 'package:flutter/material.dart';
import 'editMobil.dart';
import 'tampilData.dart';
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
          title: const Text('Menu Edit Driver'),
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
                Icons.person,
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
                        builder: (context) => const TampilData()));
              },
              leading: const Icon(
                Icons.article,
                size: 33,
              ),
              title: const Text(
                'Tampil Data',
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 15,
                    color: Color.fromARGB(255, 16, 16, 15)),
              ),
            ),
          ]),
        ),
        body: const AppNav(),
      ),
    );
  }
}

class AppNav extends StatefulWidget {
  const AppNav({super.key});

  @override
  State<AppNav> createState() => _AppNavState();
}

class _AppNavState extends State<AppNav> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          child: ListView(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: const Color.fromARGB(255, 217, 208, 208)
                              .withOpacity(0.6))
                    ]),
              ),
            ],
          )),
    );
  }
}
