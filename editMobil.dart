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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _ = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Menu Edit Mobil'),
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
                  fontSize: 15,
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
                  fontSize: 15,
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
                buttonAction: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Merek Mobil*'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Plat Mobil*'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Button(
                                          text: 'Submit',
                                          buttonAction: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text('aman')));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      });
                },
                imgDirectory: 'assets/images/addbuttonblack.png',
                iconSize: 55,
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
