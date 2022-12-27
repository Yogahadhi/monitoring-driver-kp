import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../model/dataDriver.dart';
import '../../../model/dataMobil.dart';
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
  List<bool> selectedButton = [false, false, false];
  late final TextEditingController _namaController;
  late final TextEditingController _tanggalController;
  late final TextEditingController _filenameController;
  late final TextEditingController _namaUpdateController;
  late final TextEditingController _catatanUpdateController;
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
    _catatanUpdateController = TextEditingController();
    _tanggalUpdateController = TextEditingController();
    _filenameUpdateController = TextEditingController();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _filenameController.dispose();
    _namaUpdateController.dispose();
    _catatanUpdateController.dispose();
    _tanggalUpdateController.dispose();
    _filenameController.dispose();
    super.dispose();
  }

  List readJsonSync(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  List readJsonSyncDropdown(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataMobil.fromJson(e)).toList();
  }

  void writeToFileSync(List<dynamic> content) {
    final File file = File('assets/data/driver.json');
    content.map(
      (DataDriver) => DataDriver.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

  File profilePicture(String filename) {
    if (File(filename).existsSync()) {
      return File(filename);
    } else {
      return File('assets/images/default.jpg');
    }
  }

  Widget dropDownMenu(List dataDropdown, String dropdownUpdateValue,
      String selectedUpdateValue) {
    List<DropdownMenuItem> menuItems = [];
    for (var i = 0; i < dataDropdown.length; i++) {
      if ("${dataDropdown[i].merek.toString()}(${dataDropdown[i].platmobil.toString()})," !=
          dropdownUpdateValue) {
        menuItems.add(DropdownMenuItem(
          value:
              "${dataDropdown[i].merek.toString()}(${dataDropdown[i].platmobil.toString()}),",
          child: Text(
              "${dataDropdown[i].merek.toString()}(${dataDropdown[i].platmobil.toString()}),"),
        ));
      }
    }
    menuItems.add(DropdownMenuItem(
        value: dropdownUpdateValue, child: Text(dropdownUpdateValue)));
    return DropdownButtonFormField(
        items: menuItems,
        value: dropdownUpdateValue,
        onChanged: (dropdownUpdateValue) {
          setState(() {
            selectedUpdateValue = dropdownUpdateValue;
          });
        },
        validator: (dropdownUpdateValue) {
          if (dropdownUpdateValue == null) {
            return 'Select an item';
          } else {
            return null;
          }
        });
  }

  Widget statusWidget(String status) {
    MaterialColor containerColor;
    switch (status) {
      case 'standby':
        containerColor = Colors.green;
        break;
      case 'Terpakai':
        containerColor = Colors.yellow;
        break;
      case 'Izin/Sakit':
        containerColor = Colors.red;
        break;
      default:
        containerColor = Colors.grey;
        break;
    }
    return Container(
      height: 35,
      width: 70,
      child: Card(
        color: containerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
          ],
        ),
      ),
    );
  }

  void _openImage(
      TextEditingController textEditingController, List tempList) async {
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
    file.saveTo('assets/profile/$filename');
    tempList.add(filename);
  }

  @override
  Widget build(BuildContext context) {
    List dataJson = readJsonSync('assets/data/driver.json');
    List dataDropdown = readJsonSyncDropdown('assets/data/mobil.json');
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: dataJson.length,
                itemBuilder: (context, index) {
                  final String id = dataJson[index].id.toString();
                  final String filename = dataJson[index].photodir.toString();
                  List tempUpdateFileNames = [];
                  String dropdownUpdateValue =
                      "${dataDropdown[index].merek.toString()}(${dataDropdown[index].platmobil.toString()})";
                  String selectedUpdateValue = dataJson[index].mobil.toString();
                  String toggleButtonValue = dataJson[index].status.toString();
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 50, right: 10),
                                    child: Image.file(
                                      profilePicture(
                                          'assets/profile/${dataJson[index].photodir.toString()}'),
                                      width: 150,
                                      height: 200,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 35, bottom: 10),
                                  child: Text(
                                    dataJson[index].nama.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'rubiksemi', fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, top: 10),
                                      child: Text(
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 15),
                                          'Tanggal                 : '),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 10),
                                      child: Text(
                                        dataJson[index].tanggal.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'rubiksemi',
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, top: 10),
                                      child: Text(
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 15),
                                          'Merek Mobil    : '),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 10),
                                      child: Text(
                                        dataJson[index].mobil.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'rubiksemi',
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 15),
                                          'Status                     : '),
                                    ),
                                    statusWidget(
                                        dataJson[index].status.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontSize: 15),
                                          'Catatan                : '),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        dataJson[index].catatan.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'rubiksemi',
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
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
                                        _namaUpdateController.text =
                                            dataJson[index].nama.toString();
                                        _catatanUpdateController.text =
                                            dataJson[index].catatan.toString();
                                        _tanggalUpdateController.text =
                                            dataJson[index].tanggal.toString();
                                        _filenameUpdateController.text =
                                            dataJson[index].photodir.toString();
                                        switch (
                                            dataJson[index].status.toString()) {
                                          case 'standby':
                                            selectedButton = [
                                              true,
                                              false,
                                              false
                                            ];
                                            break;
                                          case 'Terpakai':
                                            selectedButton = [
                                              false,
                                              true,
                                              false
                                            ];
                                            break;
                                          case 'Izin/Sakit':
                                            selectedButton = [
                                              false,
                                              false,
                                              true
                                            ];
                                            break;
                                          default:
                                            selectedButton = [
                                              false,
                                              false,
                                              false
                                            ];
                                            break;
                                        }
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            content: Stack(
                                              children: [
                                                Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Nama :'),
                                                            ),
                                                            SizedBox(
                                                              width: 300,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      _namaUpdateController,
                                                                  validator:
                                                                      (text) {
                                                                    final regexp =
                                                                        RegExp(
                                                                            r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z ]*)*$");
                                                                    if (text ==
                                                                            null ||
                                                                        text.isEmpty) {
                                                                      return 'Nama kosong';
                                                                    } else if (!regexp
                                                                        .hasMatch(
                                                                            text)) {
                                                                      return 'Nama hanya menerima huruf dan simbol berikut(\',.- )';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Catatan : '),
                                                            ),
                                                            SizedBox(
                                                              width: 300,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      _catatanUpdateController,
                                                                  validator:
                                                                      (text) {},
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Status :'),
                                                            ),
                                                            SizedBox(
                                                              width: 300,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    ToggleButtons(
                                                                  isSelected:
                                                                      selectedButton,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .blue,
                                                                  selectedColor:
                                                                      Colors
                                                                          .white,
                                                                  fillColor: Colors
                                                                      .lightBlue
                                                                      .shade900,
                                                                  onPressed: (int
                                                                      index) {
                                                                    setState(
                                                                        () {
                                                                      if (index ==
                                                                          0) {
                                                                        toggleButtonValue =
                                                                            'Standby';
                                                                        selectedButton =
                                                                            [
                                                                          true,
                                                                          false,
                                                                          false
                                                                        ];
                                                                      } else if (index ==
                                                                          1) {
                                                                        toggleButtonValue =
                                                                            'Terpakai';
                                                                        selectedButton =
                                                                            [
                                                                          false,
                                                                          true,
                                                                          false
                                                                        ];
                                                                      } else if (index ==
                                                                          2) {
                                                                        toggleButtonValue =
                                                                            'Izin/Sakit';
                                                                        selectedButton =
                                                                            [
                                                                          false,
                                                                          false,
                                                                          true
                                                                        ];
                                                                      }
                                                                    });
                                                                  },
                                                                  children: const [
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              12),
                                                                      child: Text(
                                                                          "Standby"),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              12),
                                                                      child: Text(
                                                                          "Terpakai"),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              12),
                                                                      child: Text(
                                                                          "Izin/Sakit"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Mobil* :'),
                                                            ),
                                                            SizedBox(
                                                              width: 300,
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: dropDownMenu(
                                                                      dataDropdown,
                                                                      dropdownUpdateValue,
                                                                      selectedUpdateValue)),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Tanggal:'),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextFormField(
                                                                  enabled:
                                                                      false,
                                                                  controller:
                                                                      _tanggalUpdateController,
                                                                  validator:
                                                                      (text) {
                                                                    if (text ==
                                                                            null ||
                                                                        text.isEmpty) {
                                                                      return 'Text is empty';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                              child: Button(
                                                                buttonAction:
                                                                    () async {
                                                                  DateTime? newDate = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime(
                                                                              1899),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2099));
                                                                  if (newDate ==
                                                                      null) {
                                                                    return;
                                                                  } else {
                                                                    String
                                                                        formattedDate =
                                                                        DateFormat('yyyy-MM-dd')
                                                                            .format(newDate);
                                                                    _tanggalUpdateController
                                                                            .text =
                                                                        formattedDate;
                                                                  }
                                                                },
                                                                text:
                                                                    'Pilh tanggal',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Text('Foto:'),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  enabled:
                                                                      false,
                                                                  controller:
                                                                      _filenameUpdateController,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                              child: Button(
                                                                  buttonAction:
                                                                      () {
                                                                    _openImage(
                                                                        _filenameUpdateController,
                                                                        tempUpdateFileNames);
                                                                  },
                                                                  text:
                                                                      "Pilih foto"),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Button(
                                                            text: 'Update',
                                                            buttonAction: () {
                                                              print(
                                                                  selectedUpdateValue);

                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (dataJson[
                                                                            index]
                                                                        .photodir
                                                                        .toString() !=
                                                                    _filenameUpdateController
                                                                        .text) {
                                                                  File('assets/profile/${dataJson[index].photodir.toString()}')
                                                                      .deleteSync(
                                                                          recursive:
                                                                              true);
                                                                }
                                                                var updateDriver =
                                                                    DataDriver(
                                                                  nama:
                                                                      _namaUpdateController
                                                                          .text,
                                                                  catatan:
                                                                      _catatanUpdateController
                                                                          .text,
                                                                  status:
                                                                      toggleButtonValue,
                                                                  tanggal:
                                                                      _tanggalUpdateController
                                                                          .text,
                                                                  mobil:
                                                                      selectedUpdateValue,
                                                                  photodir:
                                                                      _filenameUpdateController
                                                                          .text,
                                                                  id: dataJson[
                                                                          index]
                                                                      .id,
                                                                );
                                                                setState(() {
                                                                  dataJson[index]
                                                                          .nama =
                                                                      updateDriver
                                                                          .nama;
                                                                  dataJson[index]
                                                                          .catatan =
                                                                      updateDriver
                                                                          .catatan;
                                                                  dataJson[index]
                                                                          .status =
                                                                      updateDriver
                                                                          .status;
                                                                  dataJson[index]
                                                                          .tanggal =
                                                                      updateDriver
                                                                          .tanggal;
                                                                  dataJson[index]
                                                                          .mobil =
                                                                      updateDriver
                                                                          .mobil;
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
                                                                for (var element
                                                                    in tempUpdateFileNames) {
                                                                  final dir = File(
                                                                      'assets/profile/$element');
                                                                  dir.deleteSync(
                                                                      recursive:
                                                                          true);
                                                                }
                                                                tempUpdateFileNames =
                                                                    [];
                                                                selectedUpdateValue =
                                                                    '';
                                                                _namaUpdateController
                                                                    .text = '';
                                                                _catatanUpdateController
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
                                      });
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                padding: const EdgeInsets.only(left: 2),
                                onPressed: () {
                                  setState(() {
                                    dataDriver.removeWhere((element) =>
                                        element.id.toString() == id);
                                  });
                                  File('assets/profile/$filename')
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
                  var dropdownValue;
                  var selectedValue;
                  return AlertDialog(
                    content: Stack(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Nama  :'),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _namaController,
                                          validator: (text) {
                                            final regexp = RegExp(
                                                r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z ]*)*$");
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            } else if (!regexp.hasMatch(text)) {
                                              return 'Nama hanya menerima huruf dan simbol berikut(\',.- )';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Mobil :'),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButtonFormField(
                                              items: [
                                                for (var i = 0;
                                                    i < dataDropdown.length;
                                                    i++)
                                                  DropdownMenuItem(
                                                    value:
                                                        "${dataDropdown[i].merek.toString()}(${dataDropdown[i].platmobil.toString()}),",
                                                    child: Text(
                                                        "${dataDropdown[i].merek.toString()}(${dataDropdown[i].platmobil.toString()}),"),
                                                  )
                                              ],
                                              value: dropdownValue,
                                              onChanged: (dropdownValue) {
                                                setState(() {
                                                  selectedValue = dropdownValue;
                                                });
                                              },
                                              validator: (dropdownValue) {
                                                if (dropdownValue == null) {
                                                  return 'Select an item';
                                                } else {
                                                  return null;
                                                }
                                              })),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Tanggal :'),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Padding(
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
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Button(
                                        buttonAction: () async {
                                          DateTime? newDate =
                                              await showDatePicker(
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
                                            _tanggalController.text =
                                                formattedDate;
                                          }
                                        },
                                        text: 'Pilih Tanggal',
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Foto :'),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          enabled: false,
                                          controller: _filenameController,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Button(
                                        buttonAction: () {
                                          _openImage(_filenameController,
                                              tempFileNames);
                                        },
                                        text: 'Pilih Foto',
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Button(
                                    text: 'Submit',
                                    buttonAction: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          var newDriver = DataDriver(
                                              nama: _namaController.text,
                                              catatan: '',
                                              tanggal: _tanggalController.text,
                                              mobil: selectedValue,
                                              id: DateTime.now()
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
                                            final dir =
                                                File('assets/profile/$element');
                                            dir.deleteSync(recursive: true);
                                          }
                                          tempFileNames = [];
                                          selectedValue = null;
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
