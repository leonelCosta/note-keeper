import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:note_keeper_app/utilis/database_helper.dart';
 
 class NoteDetail extends StatefulWidget {

   final String appbarTitle;
   final Note note;

   NoteDetail(this.note,this.appbarTitle);


   @override
   _NoteDetailState createState() => _NoteDetailState(this.note,this.appbarTitle);
 }
 
 class _NoteDetailState extends State<NoteDetail> {

   //? variaveis 
   static var _priorities = ['High','Low'];

   TextEditingController titleControler = TextEditingController();
   TextEditingController descriptionControler = TextEditingController();

    DatabaseHelper helper = DatabaseHelper();
   
    String appbarTitle;
    Note note;

   _NoteDetailState(this.note,this.appbarTitle);

   @override
   Widget build(BuildContext context) {

     TextStyle textStyle = Theme.of(context).textTheme.title;

      //! Atualizando os dados do form com os valores que vem da bd 
     titleControler.text = note.title;
     descriptionControler.text = note.description;

     return Scaffold(
       appBar: AppBar(
         title: Text(appbarTitle),

       ),

       body: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0) ,

                    child: ListView(

                      children: <Widget>[
                        ListTile(
                            title: DropdownButton(
                                items: _priorities.map((String dropDownStringItem){

                                   return DropdownMenuItem<String>(

                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),


                                   );
                                }).toList(),

                                style: textStyle,
                                value: getPriorityAsString(note.priority),
                                onChanged: (valueSelectedByUser){
                                  
                                  setState(() {
                                      debugPrint('User selected $valueSelectedByUser'); 
                                      updatePriorityAsInt(valueSelectedByUser);
                                  });

                                },                               

                            ),

                        ),


                      //! Second Element of Form 
                      Padding(

                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: titleControler,
                          style: textStyle,
                          onChanged: (value){
                            debugPrint('Something changed in Title Text Field');
                            updateTitle();
                          },
                          decoration: InputDecoration(
                            labelText: 'Titulo',
                            hintText: 'Digite o Titulo',
                            

                          ),

                        ),



                      ),


                      //! Third Element of Form 
                      Padding(

                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: descriptionControler,
                          style: textStyle,
                          onChanged: (value){
                            debugPrint('Something changed in Description Text Field');
                            updateDescription();
                          },
                           decoration: InputDecoration(
                            labelText: 'Descrição',
                            hintText: 'Digite o Descrição',
                            

                          ),

                        ),



                      ),

                      //! Last Element of Form 
                      Padding(

                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                          children: <Widget>[

                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Save',
                                  textScaleFactor: 1.5,),
                                
                                onPressed: (){

                                  setState(() {
                                    debugPrint('Save Bottun Clicked');
                                    _save();
                                  });
                                },
                                
                              ),

                            ),

                            Container(width: 5.0,),

                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Delete',
                                  textScaleFactor: 1.6,),
                                
                                onPressed: (){

                                  setState(() {
                                    debugPrint('Delete Bottun Clicked');
                                    _delete();
                                  });
                                },
                                
                              ),

                            )



                          ],
                          

                        ),

                      )


                      ],
                      
                    ),

       )
       
     );
   }

    void moveToLastScreen(){
      Navigator.pop(context, true);
    }

    //Convert the String Priority in the form of Integer before saving it on Database 
    void updatePriorityAsInt(String value){

        switch(value){

              case 'High':
                note.priority = 1;
                break;
              case 'Low':
                note.priority = 2;
                break;
    }


    }//fim 

    //Convert int Priority to String Priority and display it to user in Dropdown  
    String getPriorityAsString(int value){

        String priority;
        switch(value){

              case 1:
                priority = _priorities[0]; // High
                break;
              case 2:
                 priority = _priorities[1]; //Low
                break;
    }

      return priority;

    }//fim 



    //update the Title of Note object
    void updateTitle(){
      note.title = titleControler.text;
    }

     //update the Description of Note object
    void updateDescription(){
       note.description = descriptionControler.text;
    }

    // SAVE data to database
    void _save() async{

      moveToLastScreen();

      note.date = DateFormat.yMMMd().format(DateTime.now());
    //   note.title = titleControler.text ;
    //   note.description = descriptionControler.text;
    //  titleControler.text = note.title;
    //  descriptionControler.text = note.description;
      int result; 
      if (note.id != null) { //case 1: Update Operation
        result = await helper.updateNote(note);

      } else {// Case 2: Insert Operation

         result = await helper.insertNote(note);

      }

      if (result != 0) { //Success 
        _showActerDialog('Status','Note save Successfully');
      } else {// Failure
        _showActerDialog('Status','Problem Saving Note');
      }

    }//end

    // DELETE data to database

    void _delete() async{

      moveToLastScreen();

        //Case 1: If user is Trying to Delete the New Note i.e he has come to the detail page by pressing the FAB of NoteList page
        if (note.id == null) {
          _showActerDialog('Status','No Note was deleted');
          return;
          
        }
        //Case 2: User is trying to delete the old note that already has a valid ID
        int result = await helper.deleteNote(note.id);
        if (result != 0) {
          _showActerDialog('Status','No Note was deleted');                
        }else{
           _showActerDialog('Status','Error Occured While Deleting Note');
        }

    }

    _showActerDialog(String title, String message){

      AlertDialog alertDialog = AlertDialog(
          title: Text(title),
          content: Text(message),
      );

      showDialog(
            context: context,
            builder: (_) => alertDialog

      );


    }

   


 }