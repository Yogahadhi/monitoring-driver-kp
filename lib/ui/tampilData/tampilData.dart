import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../editDriver/editDriver.dart';
import '../editMobil/editMobil.dart';
import '../../model/dataDriver.dart';
import 'widgets/listTampilData.dart';
import 'package:fullscreen_window/fullscreen_window.dart';


class TampilData extends StatefulWidget {
  const TampilData({super.key});

  @override
  _TampilDataState createState() => _TampilDataState();
}
class _TampilDataState extends State<TampilData> {
  Future<List<DataDriver>> readJson() async {
    final data = await rootBundle.loadString('assets/data/driver.json');
    final list = json.decode(data) as List<dynamic>;

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  void setFullscreen(bool isFullScreen){
    FullScreenWindow.setFullScreen(isFullScreen);
  }

  void initState(){
    setFullscreen(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Monitoring Driver App',
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        /*
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
        */
        body: FutureBuilder(
          future: readJson(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text('${data.error}'));
            } else if (data.hasData) {
              var dataDriver = data.data as List<DataDriver>;
              return ListTampilData(dataDriver);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
