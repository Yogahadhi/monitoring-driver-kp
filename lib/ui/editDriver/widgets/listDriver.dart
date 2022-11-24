import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import '../../../globalWidgets/ButtonIcon.dart';
import '../../../globalWidgets/button.dart';
import '../../../model/dataMobil.dart';

class ListDriver extends StatefulWidget {
  const ListDriver({Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {

  void _openImage(String saveFilePath) async{
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png', 'jpeg'],
    );
    final XFile? file =
    await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if(file == null){
      return;
    }
    final regexp = RegExp(r'\.(.+)');
    final ext = regexp.stringMatch(file.path);
    file.saveTo('assets/images/${saveFilePath}${ext}');
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      children: [
                        //upload image row
                        Column(
                          children: [
                            Button(
                                buttonAction: (){

                                }
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }

            )
        )
      ],
    );
  }
}