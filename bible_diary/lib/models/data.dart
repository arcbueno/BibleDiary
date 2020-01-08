import 'dart:convert' as convert;

class Data{
  int id;
  DateTime date;
  String textRead;
  String keyVerse;
  String resume;
  String whatLearned;
  String comment;
  String tag; // For use later

  Data({
    this.id, 
    this.date, 
    this.textRead, 
    this.keyVerse, 
    this.resume, 
    this.whatLearned, 
    this.comment, 
    this.tag
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'textRead': textRead,
      'resume':resume,
      'whatLearned': whatLearned,
      'comment': comment,
      'tag': tag
    };
  }
} 