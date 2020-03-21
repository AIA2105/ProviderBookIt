
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:day_selector/day_selector.dart';

class ProviderEdit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProviderEditState();
  }
}

class ProviderEditState extends State<ProviderEdit>{
  File _image;
  String _dropValue='Catalog A';
  String _day='';
  TimeOfDay _time = TimeOfDay.now();
  String _pickedTime1='' ;
  String _pickedTime2='' ;

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        resizeToAvoidBottomPadding:true ,
        body: Column(
          children: <Widget>[

            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
               _image == null
                  ? Image.asset('images/component.png',height: 250,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,)
                  : Image.file(_image,height: 250,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),

                Positioned(bottom: -6,
                  child: Opacity(
                    opacity: 0.5,
                    child: RaisedButton(
                      onPressed: ()=> addPhoto() ,
                      child: _image == null
                          ? Text('Add Photo')
                          : Text('Change Photo'),
                    ),
                  ),
                ),
            ],
            ),

            Expanded(child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(30),
              children: <Widget>[

                new Text('Catalog',style: TextStyle(color: Colors.lightBlueAccent,),),
                DropdownButton<String>(
                  items: <String>['Catalog A', 'Catalog B', 'Catalog C', 'Catalog D'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue){setState(() {
                    _dropValue= newValue;
                  });},
                  value: _dropValue,
                  icon: Icon(Icons.arrow_drop_down_circle,color: Colors.lightBlueAccent,),
                  isExpanded: true,
                ),

                TextField(
                  //controller: ,
                  decoration: InputDecoration(
                    labelText: 'Business Name',
                    labelStyle: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),
                  ),
                ),

                TextField(
                  //controller: ,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),
                  ),
                ),

                TextField(
                  //controller: ,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),
                  ),
                ),

                TextField(
                  //controller: ,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),
                  ),
                ),

                TextField(
                  //controller: ,
                  decoration: InputDecoration(
                    labelText: 'Website',
                    labelStyle: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),
                  ),
                ),

                Padding(padding: EdgeInsets.all(20)),
                new Text('Business Days',style: TextStyle(color: Colors.lightBlueAccent,),),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DaySelector(
                  value: null,
                  onChange: setDay ,
                  color: Colors.lightBlueAccent,
                  mode: DaySelector.modeFull,
                ),
                ),

                Padding(padding: EdgeInsets.all(20)),
                new Text('Business hours for $_day',style: TextStyle(color: Colors.lightBlueAccent,),),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  Row(
                    children: <Widget>[
                      new Text('From ',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),),
                      RaisedButton(
                        onPressed: ()=>selectTime1(context),
                        child: Text('$_pickedTime1'),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.lightBlueAccent,
                      ),
                      SizedBox(width: 80,),
                      new Text('To ',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 18),),
                      RaisedButton(
                        onPressed: ()=>selectTime2(context),
                        child: Text('$_pickedTime2'),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.all(30)),
                RaisedButton(
                  onPressed: (){},
                  child: Text('Save',style: TextStyle(fontSize: 18),),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(15),
                ),
                











              ],
            )
            )



          ],
        ),
      );
  }

  Future addPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  setDay(int value){
    setState(() {
      {
        if (DaySelector.monday & value == DaySelector.monday) {
          _day='Monday';
        }
        if (DaySelector.tuesday & value == DaySelector.tuesday) {
          _day='tuesday';
        }
        if (DaySelector.wednesday & value == DaySelector.wednesday) {
          _day='wednesday';
        }
        if (DaySelector.thursday & value == DaySelector.thursday) {
          _day='thursday';
        }
        if (DaySelector.friday & value == DaySelector.friday) {
          _day='friday';
        }
        if (DaySelector.saturday & value == DaySelector.saturday) {
          _day='saturday';
        }
        if (DaySelector.sunday & value == DaySelector.sunday) {
          _day='sunday';
        }
      }
    });
  }

  Future<Null> selectTime1(BuildContext context)async{
    _time = await showTimePicker(
        context: context,
        initialTime: _time
    );
    setState(() {
     _pickedTime1 = '${_time.hour}:${_time.minute}';

    });

  }

  Future<Null> selectTime2(BuildContext context)async{
    _time = await showTimePicker(
        context: context,
        initialTime: _time
    );
    setState(() {
      _pickedTime2 = '${_time.hour}:${_time.minute}';
    });

  }

}