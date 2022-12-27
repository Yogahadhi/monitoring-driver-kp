import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../model/dataDriver.dart';

class ListTampilData extends StatefulWidget {
  final List<DataDriver> data;

  const ListTampilData(this.data, {Key? key}) : super(key: key);

  @override
  State<ListTampilData> createState() => _ListTampilDataState();
}

class _ListTampilDataState extends State<ListTampilData> {
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

  File profilePicture(String filename) {
    if (File(filename).existsSync()) {
      return File(filename);
    } else {
      return File('assets/images/default.jpg');
    }
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

  @override
  Widget build(BuildContext context) {
    List dataJson = readJsonSync('assets/data/driver.json');
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisCount: 2,
        ),
        itemCount: dataJson.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 5,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 15, right: 10),
                        child: Image.file(
                          profilePicture(
                              'assets/profile/${dataJson[index].photodir.toString()}'),
                          width: 270,
                          height: 250,
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Text(
                        dataJson[index].nama.toString(),
                        style: const TextStyle(
                            fontFamily: 'rubiksemi', fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text(
                                style: TextStyle(
                                    fontFamily: 'poppins', fontSize: 15),
                                'Tanggal : '),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25, bottom: 10),
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
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text(
                                style: TextStyle(
                                    fontFamily: 'poppins', fontSize: 15),
                                'Merek Mobil : '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 10),
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
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                                style: TextStyle(
                                    fontFamily: 'poppins', fontSize: 15),
                                'Status : '),
                          ),
                          statusWidget(dataJson[index].status.toString())
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                                style: TextStyle(
                                    fontFamily: 'poppins', fontSize: 15),
                                'Catatan : '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 10),
                            child: Text(
                              dataJson[index].catatan.toString(),
                              style: const TextStyle(
                                  fontFamily: 'rubiksemi', fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
