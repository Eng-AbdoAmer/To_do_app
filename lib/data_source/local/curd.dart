import 'package:sqflite/sqlite_api.dart';
import 'helper.dart';
import '../../model/note_model.dart';

import '../../utils/constants.dart';

class CURD{
  //carete single instance
CURD._();
static final CURD curd=CURD._();

Database? db;

Future<void> init()async
{
  db = await Helper.helper.createDB();

}
//insert
  Future<int> insertNote(Note note)async {
   return await db!.insert(TABLE_NAME, note.tomap());
  }
  //selected

  Future<List<Note>> viewNotesFromDB()async {
    db??=await Helper.helper.createDB();
    // if(db==null)init();//this if to when db not create call fun init to create db;
    List<Map<String,dynamic>>result = await  db!.query(TABLE_NAME,orderBy: "$Col_Date desc");
    return result.map((e) => Note.fromMap(e)).toList();
  }
//delete

  Future<int> DeleteNote(int? noteId) async{
    return await db!.delete(TABLE_NAME,where:" $COL_ID=?",whereArgs: [noteId]);
  }
//update
  Future<int> UpDateNote(Note mYnote) async{
    return await db!.update(TABLE_NAME,mYnote.tomap(),where:'$COL_ID=?' ,whereArgs: [mYnote.noteId]);
  }




} 