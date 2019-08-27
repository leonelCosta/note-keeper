import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper_app/models/note.dart';




class DatabaseHelper {

    //static DatabaseHelper._createInstance(); // Named construtor to create instance of DatabaseHelper

    static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper    
    static Database _database; //Singleton Database

    String noteTable = 'note_table'; 
    String colId = 'id';
    String colTitle = 'title';
    String colDescription = 'description';
    String colPriority = 'priority';
    String colDate = 'date';

    DatabaseHelper._createInstance(); // Named construtor to create instance of DatabaseHelper

    factory DatabaseHelper(){

        if(_databaseHelper == null){
            _databaseHelper = DatabaseHelper._createInstance();
        }

        return _databaseHelper;
    }//end 

    Future<Database> get database async{

        if(_database == null){
          _database = await initializeDatabase();
        }

        return _database;

    }

    Future<Database> initializeDatabase() async {
        //GEt  the Directory path for both Android and IOS to store Database

        Directory directory = await getApplicationDocumentsDirectory();

        String path = directory.path + 'notes.db';

        //Open/Create the database at a givemn path 
        var notesDatabase = await openDatabase(path, version:1 ,onCreate: _createDb);  // call o criador da tabela      
        return notesDatabase;
    }

    void _createDb(Database db, int newVersion) async{ // criador da tabela

      await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');

    }

    //fetch Operation: Get all note objects from database

    Future<List<Map<String, dynamic>>>  getNoteMapList() async{

        Database db = await this.database;
       // var result = await db.rawQuery('Select * from $noteTable order by $colPriority ASC');
        var result = await db.query(noteTable, orderBy:'$colPriority ASC');
        return result;

    }
    //Insert Operation: Insert a Note Object to database 

    Future<int> insertNote(Note note) async {
       Database db = await this.database;
       var result = await db.insert(noteTable, note.toMap());
      return result; 
    }

    //Update Operation: Update a Note Object and save it to database 
     Future<int> updateNote(Note note) async {
       var db = await this.database;
       var result = await db.update(noteTable, note.toMap(),where: '$colId  =?',whereArgs: [note.id]);       
       return result; 
    }

    //Delete Operation. Delete a Note Obejct from database 
     Future<int> deleteNote(int id) async {
       var db = await this.database;
       var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');       
       return result; 
    }

    //Get Number of Note Objects in database 
    Future<int> getCount() async {
       Database db = await this.database;
       List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
       int result = Sqflite.firstIntValue(x);
      return result; 
    }

    // Get the 'Map List' and convert it to Note List [ List<note> ]
    Future<List<Note>> getNoteList() async{
      
        var  noteMapList = await getNoteMapList(); // GEt Map List from database 
        int count = noteMapList.length; // count the number of map entries in db table

        List<Note> noteList = List<Note>(); // lista vaziaaa

        //For loop to create a 'Note List' from a Map List
        for(int i=0; i<count; i++){

            noteList.add(Note.fromMapObject(noteMapList[i]));
        }

        return noteList;

    }


}