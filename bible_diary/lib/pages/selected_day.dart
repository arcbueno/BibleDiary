import 'package:bible_diary/custom_widgets/drawer.dart';
import 'package:bible_diary/database/data_dao.dart';
import 'package:flutter/material.dart';
import 'package:bible_diary/models/data.dart';
import 'package:bible_diary/utils/utils.dart';

class SelectedDay extends StatelessWidget {
  final utils = Utils();

  final currentDate;

  SelectedDay({@required this.currentDate});

  @override
  Widget build(BuildContext context) {
    var title = currentDate.day.toString() +
        " de " +
        utils.months[currentDate.month] +
        " de " +
        currentDate.year.toString();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(title),
          centerTitle: true,
        ),
        drawer: MyDrawer(
          contexto: context,
        ),
        body: _body());
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        child: MyForm(
          currentDate: currentDate,
        ),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  var currentDate;

  MyForm({this.currentDate});

  final _formkey = GlobalKey<FormState>();
  final dao = DataDAO();
  @override
  Widget build(BuildContext context) {
    String textRead, keyVerse, resume, whatLearned, comment;
    final _textReadController = TextEditingController();
    final _keyVerseController = TextEditingController();
    final _resumeController = TextEditingController();
    final _whatLearnedController = TextEditingController();
    final _commentController = TextEditingController();

    _onSaveAsync() async {
      var formDone = Data();
      formDone.date = currentDate.toIso8601String();
      formDone.textRead = _textReadController.text;
      formDone.whatLearned = _whatLearnedController.text;
      formDone.resume = _resumeController.text;
      formDone.keyVerse = _keyVerseController.text;
      formDone.comment = _commentController.text;
      var integer = await dao.saveAsync(formDone);
      _formkey.currentState.save();
    }

    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _textReadController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Texto lido', labelText: 'Texto lido'),
                        validator: (args) {
                          if (args.length == 0) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Sem texto, não há reflexão'),
                            ));
                          }
                        },
                        onSaved: (args) => textRead = args,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _keyVerseController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Versículo Chave',
                            labelText: 'Versículo Chave'),
                        onSaved: (args) => keyVerse = args,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          TextFormField(
            controller: _resumeController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration:
                InputDecoration(hintText: 'Resumo', labelText: 'Resumo'),
            onSaved: (args) => resume = args,
          ),
          TextFormField(
            controller: _whatLearnedController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                hintText: 'O que aprendeu', labelText: 'O que aprendeu'),
            onSaved: (args) => whatLearned = args,
          ),
          TextFormField(
            controller: _commentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                hintText: 'Comentário', labelText: 'Comentário  '),
            onSaved: (args) => comment = args,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(
                width: 15,
              ),
              RaisedButton(
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    _onSaveAsync();
                    print('saved');
                    Navigator.pop(context);
                  })
            ],
          )
        ],
      ),
    );
  }
}
