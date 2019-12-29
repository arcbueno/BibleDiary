import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:flutter/material.dart';

class SelectedDay extends StatelessWidget {

  final currentDate;

  SelectedDay({this.currentDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(currentDate.toString()),
        centerTitle: true,
      ),
      drawer: MyDrawer(contexto: context,),
      body: _body()
    );
  }

  _body(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}