import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../globalWidgets/button.dart';
import '../../../model/dataMobil.dart';

class ListMobil extends StatefulWidget {
  final List<DataMobil> data;
  const ListMobil(this.data,{Key? key}) : super(key: key);

  @override
  State<ListMobil> createState() => _ListMobilState();
}

class _ListMobilState extends State<ListMobil> {
  final _formKey = GlobalKey<FormState>();
  final _merekController = TextEditingController();
  final _platMobilController = TextEditingController();
  late List<DataMobil> dataMobil;

  @override
  void initState() {
    dataMobil = widget.data;
    super.initState();
  }

  void writeToFile(List<DataMobil> content){
    final File file = File('assets/mobil.json');
    content.map(
          (DataMobil) => DataMobil.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: dataMobil.length,
            itemBuilder: (context, index) {
              final merekUpdateController = TextEditingController(text: dataMobil[index].merek.toString());
              final platMobilUpdateController = TextEditingController(text: dataMobil[index].platmobil.toString());
              final String id = dataMobil[index].id.toString();
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
                              dataMobil[index].merek.toString(),
                              style: const TextStyle(
                                  fontFamily: 'rubiksemi', fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              dataMobil[index].platmobil.toString(),
                              style: const TextStyle(
                                  fontFamily: 'rubikr', fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
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
                                                        controller: merekUpdateController,
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
                                                      child: Text('Plat Mobil*'),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: platMobilUpdateController,
                                                        validator: (text) {
                                                          if (text == null || text.isEmpty) {
                                                            return 'Text is empty';
                                                          }
                                                          else{
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
                                                                merek: merekUpdateController.text,
                                                                platmobil: platMobilUpdateController.text,
                                                                id: dataMobil[index].id,
                                                            );
                                                            setState(() {
                                                              dataMobil[index].merek = updateMobil.merek;
                                                              dataMobil[index].platmobil = updateMobil.platmobil;
                                                            });
                                                            writeToFile(dataMobil);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },
                              icon:const Icon(Icons.edit)
                          ),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  dataMobil.removeWhere((element) => element.id.toString() == id);
                                });
                                writeToFile(dataMobil);
                              },
                              icon:const Icon(Icons.delete)
                          )
                        ],
                      )
                    ],
                  )
                ),
              );
            }),
      ),

      //TOMBOL UNTUK TAMBAH DATA
      ButtonImage(
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
                                      return 'Text is empty';
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
                                    if (text == null || text.isEmpty) {
                                      return 'Text is empty';
                                    }
                                    else{
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
                                          platmobil: _platMobilController.text,
                                          id: DateTime.now().millisecondsSinceEpoch
                                      );
                                      setState(() {
                                        dataMobil.add(newMobil);
                                      });
                                      writeToFile(dataMobil);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                      )
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


