import 'package:flutter/material.dart';
import 'editMobil.dart';
import 'editDriver.dart';
import 'main.dart';

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
          title: Text('Menu Menampilkan Data'),
        ),
        drawer: Drawer(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.bottomLeft,
              child: Text(
                "Menu Pilihan",
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 20,
                    color: Color.fromARGB(255, 223, 239, 212)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              leading: Icon(
                Icons.home,
                size: 33,
              ),
              title: Text(
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
              leading: Icon(
                Icons.person,
                size: 33,
              ),
              title: Text(
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
              leading: Icon(
                Icons.article,
                size: 33,
              ),
              title: Text(
                'Edit Driver',
                style: TextStyle(
                    fontFamily: 'rubiksemi',
                    fontSize: 15,
                    color: Color.fromARGB(255, 16, 16, 15)),
              ),
            ),
          ]),
        ),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        )),
      ),
    );
  }
}
