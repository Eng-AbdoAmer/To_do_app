import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../utils/constants.dart';

class Helper{
  //create single instance
  Helper._();
  static final Helper helper=Helper._();
  //get db path
  Future<String> _getAppDBPath()async{
    String  dbpath= await getDatabasesPath();//creat path by package path 
    String appDBpath = join(dbpath,DB_NAME);//add my app to this path 
    return appDBpath;
  }
  //create db or open table db 
  //if my db created done then open db 
  Future<Database> createDB()async{
    String path=await  _getAppDBPath();//call my fun getAPPDBPath to return string path
    return openDatabase(path,version: DB_version,onCreate: (db,version)=>_onCreateDB(db));
  }

  void _onCreateDB(Database db) {
    try{
      String sql='create table $TABLE_NAME ($COL_ID integer primary key autoincrement,$COL_TEXT text,$Col_Date text,$Col_Time text)';
      print(sql);
      db.execute(sql);
    }catch(e){
      print("invalid sql statement");
    }
    
  }
} 