import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:bible_diary/pages/selected_day.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Diário da Bíblia"),
        centerTitle: true,
      ),
      body: _body(context),
      drawer: _drawer(context),
    );
  }

  _body(context){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TableCalendar(
            calendarController: CalendarController(),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              selectedColor: Colors.blue,
              todayColor: Colors.blueGrey,
              markersColor: Colors.cyan
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: true
            ),
            onDaySelected: (date, events) =>_onDaySelected(context,date),
          ),
        ],
      )
    );
  }

  _drawer(context){
    return MyDrawer(contexto: context,);
  }

  _onDaySelected(context,date){

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => SelectedDay(currentDate: date,)
    ));

  }
}
