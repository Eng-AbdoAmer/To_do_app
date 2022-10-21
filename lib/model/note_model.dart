import '../utils/constants.dart';

class Note{
  int? noteId;
  String? noteTitle;
  String? noteDate;
  String? noteTime;
  Note({this.noteId, required this.noteTitle,required this.noteDate,required this.noteTime});

  //convert object to map
  Map<String,dynamic>tomap(){
    return {COL_ID :noteId,COL_TEXT:noteTitle,Col_Date:noteDate,Col_Time:noteTime};
  }


//convert map to object
Note.fromMap(Map<String,dynamic>map){
  noteId = map[COL_ID];
  noteTitle=map[COL_TEXT];
  noteTime=map[Col_Time];
  noteDate=map[Col_Date];
}
}