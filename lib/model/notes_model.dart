class NotesModel {
  final int? id;
  final String title;
  final String body;


  NotesModel({this.id, required this.title, required this.body});

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "title":title,
      "body":body
    };
  }

  NotesModel.fromMap(Map<String, dynamic> res):
    id = res["id"],
    title = res["title"],
    body = res["body"];


}