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
  void initState(){
    dataDriver = widget.data;
    super.initState();
  }

  List readJsonSync(String filename) {
    final File file = File(filename);
    final list = json.decode(file.readAsStringSync());

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    List dataJson = readJsonSync('assets/data/driver.json');
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: dataJson.length,
        itemBuilder: (context, index){
          return Container(
            constraints: BoxConstraints(maxHeight: 300),
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
                        padding: const EdgeInsets.only(
                            top: 15, right: 10),
                        child: Image.file(
                          File(
                              'assets/images/${dataJson[index].photodir.toString()}'),
                          width: 120,
                          height: 160,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5),
                      child: Text(
                        dataJson[index].nama.toString(),
                        style: const TextStyle(
                            fontFamily: 'rubiksemi', fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'poppins', fontSize: 15),
                              'Tujuan : '),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
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
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'poppins', fontSize: 15),
                              'Tanggal : '),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 5),
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
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'poppins', fontSize: 15),
                              'Merek Mobil : '),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 5),
                          child: Text(
                            dataJson[index].mobil.toString(),
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
        });
  }

}