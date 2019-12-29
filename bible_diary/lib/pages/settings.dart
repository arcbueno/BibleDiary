import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Diário da Bíblia"),
        centerTitle: true,
      ),
      drawer: MyDrawer(contexto: context,),
      body: Container()
    );
  }
}