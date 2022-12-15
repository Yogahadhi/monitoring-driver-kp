import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import '../editDriver/editDriver.dart';
import '../editMobil/editMobil.dart';
import '../../model/dataDriver.dart';
import 'widgets/listTampilData.dart';
import 'package:fullscreen_window/fullscreen_window.dart';


class TampilData extends StatefulWidget {
  const TampilData({super.key});

  @override
  _TampilDataState createState() => _TampilDataState();
}
class _TampilDataState extends State<TampilData> {
  Future<List<DataDriver>> readJson() async {
    final data = await rootBundle.loadString('assets/data/driver.json');
    final list = json.decode(data) as List<dynamic>;

    return list.map((e) => DataDriver.fromJson(e)).toList();
  }

  void setFullscreen(bool isFullScreen){
    FullScreenWindow.setFullScreen(isFullScreen);
  }

  void initState(){
    setFullscreen(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event){
        if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
          setFullscreen(false);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp()));
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Monitoring Driver App',
        home: Scaffold(
          backgroundColor: Colors.greenAccent,
          body: FutureBuilder(
            future: readJson(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text('${data.error}'));
              } else if (data.hasData) {
                var dataDriver = data.data as List<DataDriver>;
                return ListTampilData(dataDriver);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
}
