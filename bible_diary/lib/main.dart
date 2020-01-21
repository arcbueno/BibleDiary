import 'package:bible_diary/pages/new_study.dart';
import 'package:bible_diary/pages/selected_day.dart';
import 'package:bible_diary/pages/settings.dart';
import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  initializeDateFormatting().then((_) {
    Stetho.initialize();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/settings': (context) => Settings(),
        '/newStudy': (context) => NewStudy(),
        '/selecteDay': (context) => SelectedDay()
      },
    );
  }
}
