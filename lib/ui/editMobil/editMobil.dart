import 'dart:convert';
import 'package:flutter/material.dart';
import '../../ui/editMobil/widgets/listMobil.dart';
import '../../model/dataMobil.dart';
import '../tampilData/tampilData.dart';
import '../../main.dart';
import 'package:flutter/services.dart';


class EditMobil extends StatefulWidget {
  const EditMobil({super.key});

  @override
  _EditMobilState createState() => _EditMobilState();
}

class _EditMobilState extends State<EditMobil> {

  Future<List<DataMobil>> readJson() async {
    final data = await rootBundle.loadString('assets/data/mobil.json');
    final list = json.decode(data) as List<dynamic>;

    return list.map((e) => DataMobil.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Menu Edit Mobil'),
      ),
      drawer: Drawer(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.bottomLeft,
            child: const Text(
              "Menu Pilihan",
              style: TextStyle(
                  fontFamily: 'rubiksemi',
                  fontSize: 20,
                  color: Color.fromARGB(255, 223, 239, 212)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TampilData()));
            },
            leading: const Icon(
              Icons.article,
              size: 33,
            ),
            title: const Text(
              'Tampil Data',
              style: TextStyle(
                  fontFamily: 'rubiksemi',
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 16, 15)),
            ),
          ),
        ]),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text('${data.error}'));
          } else if (data.hasData) {
            var dataMobil = data.data as List<DataMobil>;
            return ListMobil(dataMobil);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}