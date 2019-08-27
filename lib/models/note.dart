class Note{


  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;


  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id,this._title, this._date, this._priority, [this._description]);


  //Get and Set
  int get id => _id;
  String get title =>  _title;
  String get description =>  _description;
  String get date =>  _date;
  int get priority =>  _priority;

  set title(String newTitle){
    if(newTitle.length <= 255){
        this._title = newTitle;
    }
  }

  set description(String newDescription){
    if(newDescription.length <= 255){
        this._description = newDescription;
    }
  }

  set priority(int newPrioriy){
    if(newPrioriy >= 1 && newPrioriy <= 2){
        this._priority = newPrioriy;
    }
  }

  set date(String newDate){
    if(newDate.length <= 255){
        this._date = newDate;
    }
  }



  //Convert a Note object into a Map Obeject

  Map<String, dynamic> toMap(){

    var map = Map<String, dynamic>();

    if(id != null){
      map['id']  = _id;
    }    

    map['title']  = _title;
    map['description']  = _description;
    map['priority']  = _priority;
    map['date']  = _date;

    return map;

  }


  //Extract a Note Object a Map Object 

  Note.fromMapObject(Map<String, dynamic>map){

      this._id  = map['id'];
      this._title = map['title'];
      this._date = map['date'];
      this._priority = map['priority'];
      this._description = map['description'];

  }


}