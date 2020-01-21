import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:bible_diary/database/data_dao.dart';
import 'package:bible_diary/models/data.dart';
import 'package:bible_diary/pages/selected_day.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      calendarController: _calendarController,
    );
  }
}

class HomePage extends StatelessWidget {
  var dao = DataDAO();
  var tappedDate = DateTime.now();
  var alreadyTapped = false;
  var calendarController;

  HomePage({@required this.calendarController});

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

  _body(context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TableCalendar(
          locale: "pt_br",
          calendarController: calendarController,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          calendarStyle: CalendarStyle(
              selectedColor: Colors.blue,
              todayColor: Colors.blueGrey,
              markersColor: Colors.cyan),
          headerStyle:
              HeaderStyle(centerHeaderTitle: true, formatButtonVisible: true),
          onDaySelected: (date, events) => _onTap(date, context),
        ),
        _buildEventList()
      ],
    ));
  }

  _onTap(date, context) {
    if (date == tappedDate) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectedDay(
                    currentDate: date,
                  )));
    } else {
      tappedDate = date;
      _buildEventList();
    }
  }

  _drawer(context) {
    return MyDrawer(
      contexto: context,
    );
  }

  Widget _buildEventList() {
    return FutureBuilder(
        future: dao.getByDateAsync(tappedDate),
        initialData: "No date selected",
        builder: (context, projectSnap) {
          if (projectSnap.hasError) {
            print("errou feio, errou rude");
            return CircularProgressIndicator();
          }
          if (projectSnap.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }

          if (projectSnap.connectionState == ConnectionState.none ||
              projectSnap.data == null) {
            print("no data");
            return Container(
              child: Icon(Icons.device_unknown),
            );
          }
          return Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: projectSnap.data.length,
              itemBuilder: (context, index) {
                print(projectSnap.data.toString());
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(projectSnap.data[index].textRead),
                  ),
                );
              },
            ),
          );
        });
  }
}
