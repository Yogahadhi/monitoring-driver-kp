import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../model/dataDriver.dart';
import 'package:intl/intl.dart';

class ListDriver extends StatefulWidget {
  final List<DataDriver> data;

  const ListDriver(this.data, {Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  final _formKey = GlobalKey<FormState>();
  late List<DataDriver> dataDriver;
  late final TextEditingController _namaController;
  late final TextEditingController _tanggalController;
  late final TextEditingController _filenameController;
  late final TextEditingController _namaUpdateController;
  late final TextEditingController _tujuanUpdateController;
  late final TextEditingController _tanggalUpdateController;
  late final TextEditingController _filenameUpdateController;

  @override
  void initState() {
    dataDriver = widget.data;
    super.initState();
    _namaController = TextEditingController();
    _tanggalController = TextEditingController();
    _filenameController = TextEditingController();
    _namaUpdateController = TextEditingController();
    _tujuanUpdateController = TextEditingController();
    _tanggalUpdateController = TextEditingController();
    _filenameUpdateController = TextEditingController();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _filenameController.dispose();
    _namaUpdateController.dispose();
    _tujuanUpdateController.dispose();
    _tanggalUpdateController.dispose();
    _filenameController.dispose();
    super.dispose();
  }

  List readJsonSync(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  void writeToFileSync(List<dynamic> content) {
    final File file = File('assets/data/driver.json');
    content.map(
          (DataDriver) => DataDriver.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

  void _openImage(TextEditingController textEditingController,
      List tempList) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png', 'jpeg'],
    );
    final XFile? file =
    await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) {
      return;
    }
    final regexp = RegExp(r'[^\\]*$');
    final filename = regexp.stringMatch(file.path);
    textEditingController.text = filename ?? '';
    file.saveTo('assets/images/$filename');
    tempList.add(filename);
  }

  @override
  Widget build(BuildContext context) {
    List dataJson = readJsonSync('assets/data/driver.json');
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: dataJson.length,
                itemBuilder: (context, index) {
                  final String id = dataJson[index].id.toString();
                  final String filename = dataJson[index].photodir.toString();
                  List tempUpdateFileNames = [];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: [
                        //Image/name column
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 10),
                                child: Image.file(
                                  File(
                                      'assets/images/${dataJson[index].photodir
                                          .toString()}'),
                                  width: 150,
                                  height: 200,
                                )),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 8, bottom: 10),
                              child: Text(
                                dataJson[index].nama.toString(),
                                style: const TextStyle(
                                    fontFamily: 'rubiksemi', fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        //Other data column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                      style: TextStyle(
                                          fontFamily: 'poppins', fontSize: 15),
                                      'Tujuan : '),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    dataJson[index].tujuan.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'rubiksemi', fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                      style: TextStyle(
                                          fontFamily: 'poppins', fontSize: 15),
                                      'Tanggal : '),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, top: 10),
                                  child: Text(
                                    dataJson[index].tanggal.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'rubiksemi', fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                      style: TextStyle(
                                          fontFamily: 'poppins', fontSize: 15),
                                      'Merek Mobil : '),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, top: 10),
                                  child: Text(
                                    dataJson[index].mobil.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'rubiksemi', fontSize: 16),
                                  ),
                                ),
                              ],
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
                                        return AlertDialog(
                                          content: Stack(
                                            children: [
                                              Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0),
                                                        child: Text(
                                                            'Nama'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: TextFormField(
                                                          controller: _namaUpdateController,
                                                          validator: (text) {
                                                            if (text == null ||
                                                                text.isEmpty) {
                                                              return 'Text is empty';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                        EdgeInsets.all(8.0),
                                                        child:
                                                        Text('Tujuan'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: TextFormField(
                                                          controller: _tujuanUpdateController,
                                                          validator: (text) {
                                                            if (text == null ||
                                                                text.isEmpty) {
                                                              return 'Text is empty';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0),
                                                        child: Text('Tanggal'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: TextFormField(
                                                          enabled: false,
                                                          controller: _tanggalUpdateController,
                                                          validator: (text) {
                                                            if (text == null ||
                                                                text.isEmpty) {
                                                              return 'Text is empty';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Button(
                                                        buttonAction: () async {
                                                          DateTime? newDate = await showDatePicker(
                                                              context: context,
                                                              initialDate: DateTime
                                                                  .now(),
                                                              firstDate: DateTime(
                                                                  1899),
                                                              lastDate: DateTime(
                                                                  2099));
                                                          if (newDate == null) {
                                                            return;
                                                          } else {
                                                            String formattedDate =
                                                            DateFormat(
                                                                'yyyy-MM-dd')
                                                                .format(
                                                                newDate);
                                                            _tanggalUpdateController
                                                                .text =
                                                                formattedDate;
                                                          }
                                                        },
                                                        text: 'select date',
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(
                                                            8.0),
                                                        child: Text('Foto'),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: TextField(
                                                          enabled: false,
                                                          controller: _filenameUpdateController,
                                                        ),
                                                      ),
                                                      Button(buttonAction: () {
                                                        _openImage(
                                                            _filenameUpdateController,
                                                            tempUpdateFileNames);
                                                      }),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Button(
                                                          text: 'Update',
                                                          buttonAction: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              Directory(
                                                                  'assets/images/${dataJson[index]
                                                                      .photodir
                                                                      .toString()}')
                                                                  .deleteSync(
                                                                  recursive: true);
                                                              var updateDriver =
                                                              DataDriver(
                                                                nama: _namaUpdateController
                                                                    .text,
                                                                tujuan: _tujuanUpdateController
                                                                    .text,
                                                                tanggal: _tanggalUpdateController
                                                                    .text,
                                                                photodir: _filenameUpdateController
                                                                    .text,
                                                                id: dataJson[index]
                                                                    .id,
                                                              );
                                                              setState(() {
                                                                dataJson[index]
                                                                    .nama =
                                                                    updateDriver
                                                                        .nama;
                                                                dataJson[index]
                                                                    .tujuan =
                                                                    updateDriver
                                                                        .tujuan;
                                                                dataJson[index]
                                                                    .tanngal =
                                                                    updateDriver
                                                                        .tanggal;
                                                                dataJson[index]
                                                                    .photodir =
                                                                    updateDriver
                                                                        .photodir;
                                                              });
                                                              writeToFileSync(
                                                                  dataJson);
                                                              tempUpdateFileNames
                                                                  .remove(
                                                                  _filenameUpdateController
                                                                      .text);
                                                              for (var element in tempUpdateFileNames) {
                                                                final dir = Directory(
                                                                    'assets/images/$element');
                                                                dir.deleteSync(
                                                                    recursive: true);
                                                              }
                                                              tempUpdateFileNames =
                                                              [];
                                                              _namaUpdateController
                                                                  .text = '';
                                                              _tujuanUpdateController
                                                                  .text = '';
                                                              _tanggalUpdateController
                                                                  .text = '';
                                                              _filenameUpdateController
                                                                  .text = '';
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
                                  setState(() {
                                    dataDriver.removeWhere((element) =>
                                    element.id.toString() == id);
                                  });
                                  Directory('assets/images/$filename')
                                      .deleteSync(recursive: true);
                                  writeToFileSync(dataDriver);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  );
                })),
        //Button add data
        ButtonImage(
          buttonAction: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  List tempFileNames = [];
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
                                  child: Text('Nama*'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _namaController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Text is empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Tanggal*'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _tanggalController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Text is empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Button(
                                  buttonAction: () async {
                                    DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1899),
                                        lastDate: DateTime(2099));
                                    if (newDate == null) {
                                      return;
                                    } else {
                                      String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(newDate);
                                      _tanggalController.text = formattedDate;
                                    }
                                  },
                                  text: 'select date',
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Foto'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    enabled: false,
                                    controller: _filenameController,
                                  ),
                                ),
                                Button(buttonAction: () {
                                  _openImage(
                                      _filenameController, tempFileNames);
                                }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                    text: 'Submit',
                                    buttonAction: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          var newDriver = DataDriver(
                                              nama: _namaController.text,
                                              tujuan: '',
                                              tanggal: _tanggalController.text,
                                              mobil: 'placeholder',
                                              id: DateTime
                                                  .now()
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              photodir:
                                              _filenameController.text,
                                              status: 'standby');
                                          dataDriver.add(newDriver);
                                          writeToFileSync(dataDriver);
                                          tempFileNames
                                              .remove(_filenameController.text);
                                          for (var element in tempFileNames) {
                                            final dir = Directory(
                                                'assets/images/$element');
                                            dir.deleteSync(recursive: true);
                                          }
                                          tempFileNames = [];
                                          _namaController.text = '';
                                          _tanggalController.text = '';
                                          _filenameController.text = '';
                                        });
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
      ],
    );
  }
}