import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../globalWidgets/button.dart';
import '../../../model/dataDriver.dart';
import '../../../model/dataMobil.dart';

class ListMobil extends StatefulWidget {
  final List<DataMobil> data;

  const ListMobil(this.data, {Key? key}) : super(key: key);

  @override
  State<ListMobil> createState() => _ListMobilState();
}

class _ListMobilState extends State<ListMobil> {
  final _formKey = GlobalKey<FormState>();
  late List<DataMobil> dataMobil;
  late final TextEditingController _merekController;
  late final TextEditingController _platMobilController;
  late final TextEditingController _merekUpdateController;
  late final TextEditingController _platMobilUpdateController;

  @override
  void initState() {
    dataMobil = widget.data;
    super.initState();
    _merekController = TextEditingController();
    _platMobilController = TextEditingController();
    _merekUpdateController = TextEditingController();
    _platMobilUpdateController = TextEditingController();
  }

  @override
  void dispose() {
    _merekController.dispose();
    _platMobilController.dispose();
    _merekUpdateController.dispose();
    _platMobilUpdateController.dispose();
    super.dispose();
  }

  List readJsonSync(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataMobil.fromJson(e)).toList();
  }

  List readJsonSyncDriver(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  void writeToFileSync(List<dynamic> content) {
    final File file = File('assets/data/mobil.json');
    content.map(
          (DataMobil) => DataMobil.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFileSyncDriver(List<dynamic> content) {
    final File file = File('assets/data/driver.json');
    content.map(
          (DataDriver) => DataDriver.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

  @override
  Widget build(BuildContext context) {
    List dataDriver = readJsonSyncDriver('assets/data/driver.json');
    List dataJson = readJsonSync('assets/data/mobil.json');
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: dataJson.length,
            itemBuilder: (context, index) {
              final String id = dataJson[index].id.toString();
              return Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                dataJson[index].merek.toString(),
                                style: const TextStyle(
                                    fontFamily: 'rubiksemi', fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                dataJson[index].platmobil.toString(),
                                style: const TextStyle(
                                    fontFamily: 'rubikr', fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        _merekUpdateController.text = dataJson[index].merek.toString();
                                        _platMobilUpdateController.text = dataJson[index].platmobil.toString();
                                        return AlertDialog(
                                          content: Stack(
                                            children: [
                                              Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Merek Mobil*'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                          controller: _merekUpdateController,
                                                          validator: (text) {
                                                            if (text == null || text.isEmpty) {
                                                              return 'Input kosong';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text('Plat Mobil*'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: TextFormField(
                                                          controller: _platMobilUpdateController,
                                                          validator: (text) {
                                                            final regexp = RegExp(r"^[A-Za-z]{1,2}[0-9]{1,4}[A-Za-z]{1,3}$");
                                                            if (text == null || text.isEmpty) {
                                                              return 'Input kosong';
                                                            }
                                                            else if(!regexp.hasMatch(text)){
                                                              return 'Input salah';
                                                            }
                                                            else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Button(
                                                          text: 'Update',
                                                          buttonAction: () {
                                                            if (_formKey.currentState!.validate()) {
                                                              var updateMobil = DataMobil(
                                                                merek: _merekUpdateController.text,
                                                                platmobil: _platMobilUpdateController.text.toUpperCase(),
                                                                id: dataJson[index].id,
                                                              );
                                                              var updateDriver = DataDriver(
                                                                mobil: "${_merekUpdateController.text}(${_platMobilUpdateController.text.toUpperCase()})"
                                                              );
                                                              var updateResult = dataDriver.where((element) =>
                                                                element.mobil.toString() == "${dataJson[index].merek.toString()}(${dataJson[index].platmobil.toString()})");
                                                              for (var element in updateResult){
                                                                element.mobil = updateDriver.mobil;
                                                              }
                                                              setState(() {
                                                                dataJson[index].merek = updateMobil.merek;
                                                                dataJson[index].platmobil = updateMobil.platmobil;
                                                              });
                                                              writeToFileSyncDriver(dataDriver);
                                                              writeToFileSync(dataJson);
                                                              _merekUpdateController.text = '';
                                                              _platMobilUpdateController.text = '';
                                                              Navigator.pop(context, true);
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
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  var result = dataDriver.where((element) =>
                                    element.mobil.toString() == "${dataJson[index].merek.toString()}(${dataJson[index].platmobil.toString()})");
                                  for (var element in result) {
                                    final dir = File('assets/profile/${element.photodir.toString()}');
                                    dir.deleteSync(recursive: true);
                                  }
                                  setState(() {
                                    dataDriver.removeWhere((element) =>
                                    element.mobil.toString() == "${dataJson[index].merek.toString()}(${dataJson[index].platmobil.toString()})");
                                  });
                                  writeToFileSyncDriver(dataDriver);
                                  setState(() {
                                    dataMobil.removeWhere((element) =>
                                      element.id.toString() == id);
                                  });
                                  writeToFileSync(dataMobil);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )
                      ],
                    )),
              );
            }),
      ),

      //TOMBOL UNTUK TAMBAH DATA
      ButtonImage(
        buttonAction: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                _merekController.text = '';
                _platMobilController.text = '';
                return AlertDialog(
                  content: Stack(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Merek Mobil*'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _merekController,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Input kosong';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Plat Mobil*'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _platMobilController,
                                  validator: (text) {
                                    final regexp = RegExp(r"^[A-Za-z]{1,2}[0-9]{1,4}[A-Za-z]{1,3}$");
                                    if (text == null || text.isEmpty) {
                                      return 'Input kosong';
                                    } else if(!regexp.hasMatch(text)){
                                      return 'Input salah';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Button(
                                  text: 'Submit',
                                  buttonAction: () {
                                    if (_formKey.currentState!.validate()) {
                                      var newMobil = DataMobil(
                                          merek: _merekController.text,
                                          platmobil: _platMobilController.text.toUpperCase(),
                                          id: DateTime.now().millisecondsSinceEpoch.toString());
                                      setState(() {
                                        dataMobil.add(newMobil);
                                      });
                                      writeToFileSync(dataMobil);
                                      _merekController.text = '';
                                      _platMobilController.text = '';
                                      Navigator.pop(context, true);
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
  }
}
