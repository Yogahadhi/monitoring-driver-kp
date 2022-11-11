import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monitoringdivermobilpln/editDriver.dart';
import 'package:monitoringdivermobilpln/tampilData.dart';
import 'main.dart';
import 'package:flutter/services.dart';

class EditMobil extends StatefulWidget {
  const EditMobil({super.key});

  @override
  _EditMobilState createState() => _EditMobilState();
}

class _EditMobilState extends State<EditMobil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Welcome to PT PLN UIKL Monitoring Driver'),
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
                  fontSize: 17,
                  color: Color.fromARGB(255, 16, 16, 15)),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditDriver()));
            },
            leading: Icon(
              Icons.person,
              size: 33,
            ),
            title: Text(
              'Edit Driver',
              style: TextStyle(
                  fontFamily: 'rubiksemi',
                  fontSize: 17,
                  color: Color.fromARGB(255, 16, 16, 15)),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TampilData()));
            },
            leading: Icon(
              Icons.article,
              size: 33,
            ),
            title: Text(
              'Tampil Data',
              style: TextStyle(
                  fontFamily: 'rubiksemi',
                  fontSize: 17,
                  color: Color.fromARGB(255, 16, 16, 15)),
            ),
          ),
        ]),
      ),
      body: FutureBuilder(
        future: ReadJson(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) {
            var dataMobil = data.data as List<DataMobil>;
            return Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: dataMobil == null ? 0 : dataMobil.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  dataMobil[index].merek.toString(),
                                  style: TextStyle(
                                      fontFamily: 'rubiksemi', fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  dataMobil[index].platmobil.toString(),
                                  style: TextStyle(
                                      fontFamily: 'rubikr', fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              ButtonIcon(
                buttonAction: () {},
                imgDirectory: 'assets/icons/addIcon.jpg',
                iconSize: 50,
              )
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<DataMobil>> ReadJson() async {
    final data = await rootBundle.loadString('assets/mobil.json');
    final list = json.decode(data) as List<dynamic>;

    return list.map((e) => DataMobil.fromJson(e)).toList();
  }
}

class DataMobil {
  String? merek;
  String? platmobil;

  DataMobil({this.merek, this.platmobil});

  DataMobil.fromJson(Map<String, dynamic> json) {
    merek = json['merek'];
    platmobil = json['platmobil'];
  }
}
