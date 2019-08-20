import 'package:flutter/material.dart';
 
 class NoteDetail extends StatefulWidget {
   @override
   _NoteDetailState createState() => _NoteDetailState();
 }
 
 class _NoteDetailState extends State<NoteDetail> {

   static var _priorities = ['Hight','Low'];

   TextEditingController titleControler = TextEditingController();
   TextEditingController descriptionControler = TextEditingController();

   @override
   Widget build(BuildContext context) {

     TextStyle textStyle = Theme.of(context).textTheme.title;

     return Scaffold(
       appBar: AppBar(
         title: Text('Edit Note'),

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
                                value: 'Low',
                                onChanged: (valueSelectedByUser){
                                  
                                  setState(() {
                                      debugPrint('User selected $valueSelectedByUser'); 
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
                          },

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
                          },

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



 }