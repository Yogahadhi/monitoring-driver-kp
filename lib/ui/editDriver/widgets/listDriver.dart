import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import '../../../model/dataDriver.dart';

class ListDriver extends StatefulWidget {
  final List<DataDriver> data;
  const ListDriver(this.data,{Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  final _formKey = GlobalKey<FormState>();
  late List<DataDriver> dataDriver;

  @override
  void initState(){
    dataDriver = widget.data;
    super.initState();
  }

  List readJsonSync(String filename){
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  void writeToFileSync(List<dynamic> content){
    final File file = File('assets/data/driver.json');
    content.map(
          (DataDriver) => DataDriver.toJson(),
    );
    file.writeAsStringSync(json.encode(content));
  }

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
    List dataJson = readJsonSync('assets/data/driver.json');
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: dataJson.length,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      children: [
                        //Image/name column
                        Column(
                          children: [
                            FadeInImage(
                                placeholder: AssetImage('assets/images/default.jpg'),
                                image: AssetImage('assets/images/${dataJson[index].id.toString()}.png')),
                            Text('\'Nama here\'')
                          ],
                        ),
                        //Other data column
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Merek: '),
                                Text('\'Merek here\'')
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tanggal: '),
                                Text('\'Tanggal here\'')
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tujuan: '),
                                Text('\'Tujuan here\'')
                              ],
                            ),
                            Row(
                              children: [
                                Text('Status: '),
                                Text('\'Status here\'')
                              ],
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