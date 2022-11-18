
/*
//Jangan dikacca dlu ini

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../globalWidgets/button.dart';
import '../../../model/dataMobil.dart';

Widget ListViewMobil(GlobalKey<FormState> _formkey){

  final _formKey = GlobalKey<FormState>();
  final _merekController = TextEditingController();
  final _platMobilController = TextEditingController();

  final File file = File('assets/mobil.json');
  final list = json.decode(file.readAsStringSync());

  List dataJson = list.map((e) => DataMobil.fromJson(e)).toList();

  return ListView.builder(
      itemCount: dataJson.length,
      itemBuilder: (context, index) {
        final merekUpdateController = TextEditingController(text: dataJson[index].merek.toString());
        final platMobilUpdateController = TextEditingController(text: dataJson[index].platmobil.toString());
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
                                                          id: dataJson[index].id,
                                                        );
                                                        setState(() {
                                                          dataJson[index].merek = updateMobil.merek;
                                                          dataJson[index].platmobil = updateMobil.platmobil;
                                                        });
                                                        writeToFileSync(dataJson);
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
                              dataJson.removeWhere((element) => element.id.toString() == id);
                            });
                            writeToFileSync(dataJson);
                          },
                          icon:const Icon(Icons.delete)
                      )
                    ],
                  )
                ],
              )
          ),
        );
      });
}
 */

