import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:monitoringdivermobilpln/globalWidgets/ButtonIcon.dart';
import '../../../model/dataDriver.dart';

class ListDriver extends StatefulWidget {
  final List<DataDriver> data;
  const ListDriver(this.data, {Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  final _formKey = GlobalKey<FormState>();
  late List<DataDriver> dataDriver;

  @override
  void initState() {
    dataDriver = widget.data;
    super.initState();
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

  void _openImage(String saveFilePath) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png', 'jpeg'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) {
      return;
    }
    final regexp = RegExp(r'\.(.+)');
    final ext = regexp.stringMatch(file.path);
    file.saveTo('assets/images/${saveFilePath}${ext}');
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
                              child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/default.jpg'),
                                  image: AssetImage(
                                      'assets/images/${dataJson[index].id.toString()}.png')),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 10),
                              child: Text(
                                dataJson[index].nama.toString(),
                                style: const TextStyle(
                                    fontFamily: 'rubiksemi', fontSize: 16),
                              ),
                            ),
                            //Text('\'Nama here\'')
                          ],
                        ),
                        //Other data column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                      style: const TextStyle(
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                      style: const TextStyle(
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                      style: const TextStyle(
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
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                      style: const TextStyle(
                                          fontFamily: 'poppins', fontSize: 15),
                                      'Id Data : '),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 10),
                                  child: Text(
                                    dataJson[index].id.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'rubiksemi', fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })),

        //Button add data
        ButtonImage(
          buttonAction: () {},
          imgDirectory: 'assets/images/addbuttonblack.png',
          iconSize: 55,
        )
      ],
    );
  }
}
