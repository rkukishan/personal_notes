class NotesModel {
  final int? id;
  final String title;
  final String body;
  final String datetime;

  NotesModel({this.id, required this.title, required this.body, required this.datetime});

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "title":title,
      "body":body,
      "datetime":datetime,
    };
  }

  NotesModel.fromMap(Map<String, dynamic> res):
    id = res["id"],
    title = res["title"],
    body = res["body"],
    datetime = res["datetime"];

}