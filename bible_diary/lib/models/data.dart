import 'dart:convert' as convert;

class Data{
  int id;
  DateTime date;
  String textRead;
  String keyVerse;
  String resume;
  String whatLearned;
  String comment;
  String tag; // To be used 

  String toJson(){
    return convert.json.encode(toMap());
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['textRead'] = this.textRead;
    data['keyVerse'] = this.keyVerse;
    data['resume'] = this.resume;
    data['whatLearned'] = this.whatLearned;
    data['comment'] = this.comment;
    data['tag'] = this.tag;
    return data;
  }
}