import 'dart:async';
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
  int currentPage = 0;
  late Timer timer;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    dataDriver = widget.data;
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if(currentPage < 2){
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn);
    });
  }

  @override
  void dispose(){
    super.dispose();
    timer.cancel();
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
    return SizedBox(
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

  Widget textTanggal(String tanggal1, String tanggal2){
    if(tanggal1 == '' && tanggal2 == ''){
      return const Text('');
    }
    else{
      return Text('$tanggal1 s/d $tanggal2',
        style: const TextStyle(
            fontFamily: 'rubiksemi',
            fontSize: 16),
      );
    }
  }

  Widget contentCard(List dataJson, int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    width: 220,
                    height: 200,
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
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                          style: TextStyle(
                              fontFamily: 'poppins', fontSize: 15),
                          'Lama pakai : '),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 25, bottom: 10),
                      child: textTanggal(dataJson[index].tanggalawal.toString(), dataJson[index].tanggalakhir.toString())
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
  }

  List<Widget> pageGenerator(List dataJson, int data, int multiplier){
    List<Widget> generatedPage = [];
    if (data == 0){
      for(var i = multiplier*4 ; i < (multiplier+1)*4; i++){
        generatedPage.add(contentCard(dataJson, i));
      }
    }
    else{
      for(var i = multiplier*4; i < (multiplier*4)+data; i++){
        generatedPage.add(contentCard(dataJson, i));
      }
    }
    return generatedPage;
  }

  List<Widget> contentPages(List dataJson, int jumlahPage, int dataSisa){
    List<Widget> contentPage = [];
    int multiplier = 0;
    var size = MediaQuery.of(context).size;
    if (jumlahPage != 0){
      for(var i = 0; i<jumlahPage;i++){
        contentPage.add(
            GridView.count(
              childAspectRatio: (size.height/0.58)/(size.width/2),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: pageGenerator(dataJson, 4, i),
            )
        );
        multiplier++;
      }
    }
    if (dataSisa != 0){
      contentPage.add(
          GridView.count(
            childAspectRatio: (size.height/0.58)/(size.width/2),
            //(size.height/0.58)/((size.width/2)),
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            children: pageGenerator(dataJson, dataSisa, multiplier),
          )
      );
    }
    return contentPage;
  }

  @override
  Widget build(BuildContext context){
    List dataJson = readJsonSync('assets/data/driver.json');
    int jumlahData = dataJson.length;
    int jumlahPage = jumlahData~/4;
    int dataSisa = jumlahData%4;

    return PageView(
      controller: pageController,
      children: contentPages(dataJson, jumlahPage, dataSisa)
    );
  }
}
