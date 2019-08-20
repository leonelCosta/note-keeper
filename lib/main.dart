import 'package:flutter/material.dart';
import 'package:note_keeper_app/screens/note_list.dart';
import 'package:note_keeper_app/screens/note_detail.dart';


void main() => runApp(Myapp() );





class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Note Keeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: NoteDetail(),

    );
  }
}