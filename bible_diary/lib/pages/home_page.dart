import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:bible_diary/database/data_dao.dart';
import 'package:bible_diary/models/data.dart';
import 'package:bible_diary/pages/selected_day.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatelessWidget {

  var dao = DataDAO();
  var tappedDate = DateTime.now();

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
            onDayLongPressed: (date, events) =>_onDayLongPressed(context,date),
            onDaySelected: (date, events) => tappedDate = date,
          ),
          SizedBox(height: 8.0,),
          _buildEventList()
        ],
      )
    );
  }

  _drawer(context){
    return MyDrawer(contexto: context,);
  }

  _onDayLongPressed(context,date){

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => SelectedDay(currentDate: date,)
    ));

  }

  Widget _buildEventList() {
      return FutureBuilder(
        future: dao.getByDateAsync(tappedDate),
        initialData: "No date selected",
        builder: (context, projectSnap){
          print('oi');
          if(projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null){
            return Container();
          }
          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(projectSnap.data[index].textRead),
                ),
              );
            },
          );
        }
      );

    

    // return ListView(
    //   children: obj
    //       .map((event) => Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(width: 0.8),
    //               borderRadius: BorderRadius.circular(12.0),
    //             ),
    //             
    //             child: ListTile(
    //               title: Text(event.textRead),
    //               onTap: () => print('$event tapped!'),
    //             ),
    //           ))
    //       .toList(),
    // );
  }

}
