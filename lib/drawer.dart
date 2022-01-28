import 'package:flutter/material.dart';
import 'pages/p1.dart';
import 'pages/p2.dart';
import 'pages/p3.dart';
import 'pages/p4.dart';
import 'pages/p5.dart';
import 'pages/p6.dart';
import 'pages/p7.dart';
import 'pages/p8.dart';
import 'pages/p9.dart';
import 'pages/p10.dart';
import 'services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SlideBarMenuContent_drawer extends StatefulWidget {

  @override
  _SlideBarMenuContentState createState() => _SlideBarMenuContentState();
}



class _SlideBarMenuContentState extends State<SlideBarMenuContent_drawer>{
  final myController = TextEditingController();
  FocusNode myFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
  }

  List <String> name_of_tile = ['Важно', 'Мои планы', 'Завтрашний день'];
  Widget make_page(ind){
    if (ind == 0){
      return page1(name_of_tile[ind]);
    };
    if (ind == 1){
      return page2(name_of_tile[ind]);
    };
    if (ind == 2){
    return page3(name_of_tile[ind]);
    };
    if (ind == 3){
      return page4(name_of_tile[ind]);
    };
    if (ind == 4){
      return page5(name_of_tile[ind]);
    };
    if (ind == 5){
      return page6(name_of_tile[ind]);
    };
    if (ind == 6){
      return page7(name_of_tile[ind]);
    };
    if (ind == 7){
      return page8(name_of_tile[ind]);
    };
    if (ind == 8){
      return page9(name_of_tile[ind]);
    };
    if (ind == 9){
      return page10(name_of_tile[ind]);
    };
  }


  List <IconData> icon_of_tile = [Icons.beach_access, Icons.add_a_photo, Icons.favorite];
  String _userToDo;

  void add_new_name()  {
    setState(() {
      if(_userToDo != null){
        icon_of_tile.add(Icons.beach_access);
        name_of_tile.add(myController.text);}
      });
    }


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:
        SingleChildScrollView(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DrawerHeader(
                      child: Header(),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      )),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: name_of_tile.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                          Row(
                              children: [
                                Text('${name_of_tile[index]}',
                                    style: TextStyle(color: Colors.green, fontSize: 15)
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left:6),
                                    child: Icon(
                                      icon_of_tile[index],
                                      color: Colors.green,
                                      size: 18.0,
                                    )),
                              ]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => make_page(index),)
                            );
                          },
                        );
                      }),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[600], // background
                          onPrimary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),// foreground
                        ),
                        onPressed: () {
    showDialog(context: context,
    builder: (BuildContext context){
    return AlertDialog(
      title: Text("Создать новый список", style: TextStyle(color: Colors.grey[800], fontSize: 15),
        textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content:SingleChildScrollView(    // new line
          child:
           Container(
          height: MediaQuery.of(context).size.height/3.6,
          child:
      Column(
        mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top:3),
                child: TextFormField(
                  controller: myController,
                  focusNode: myFocusNode,
                  onChanged: (String value){
                    _userToDo = value;
                  },
                  decoration: InputDecoration(focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                      labelText: 'Наименование',
                      labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.grey : Colors.grey)),)),
                Padding(padding:  EdgeInsets.only(left:6),
                    child: Row(
                        children: [
                          Text('Выберете эмблему:', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                          Padding(padding:  EdgeInsets.only(left:16),
                              child: drop_icon())])),
                /*Row(
            children: [*/
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width/1.8,
                    child: Text('Цвет эмблемы:',style: TextStyle(color: Colors.grey[700], fontSize: 12), textAlign: TextAlign.left)),
                Container(
                    width: MediaQuery.of(context).size.width/1.8,
                    child: Text('Цвет текста:',style: TextStyle(color: Colors.grey[700], fontSize: 12), textAlign: TextAlign.left))
              ]
          )
      )),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[600], // background
            onPrimary: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),// foreground
          ),
          child: Text("Отменить"),
          onPressed:  () {
            Navigator.pop(context);
            myController.text = '';
            _userToDo = null;
          },
        ),
        ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: Colors.green[600], // background
      onPrimary: Colors.white,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),// foreground
    ),
          child: Text("Сохранить"),
          onPressed:  () {
            add_new_name();
            Navigator.pop(context);
            myController.text = '';
            _userToDo = null;
          },
        ),
      ],
    );});
    },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                            [
                              Text('Добавить новый список'),
                              Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                  ))
                            ]
                        )),
                  )
                ])));
  }}

  class Header extends StatefulWidget {
    const Header({Key key}) : super(key: key);

    @override
    _HeaderState createState() => _HeaderState();
  }



class _HeaderState extends State<Header>{

  DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });}

    Future<int> addUsers() async {
      User firstUser = User(name: "Сашок", email: 'zaleshchikovaa@gmail.com');
      List<User> listOfUsers = [firstUser];
      return await this.handler.insertUser(listOfUsers);
    }
  String user_email = 'zaleshchikovaa@gmail.com';
  String user_name = 'Сашок';

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: this.handler.retrieveUsers(),
    builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot)  {
    if (snapshot.hasData) {
      return Column(
        children: [
          Center(
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white
                /*child: ClipOval(
              ),*/
              )),
          Container(
              margin: EdgeInsets.only(top: 5, bottom:5),
              child:
              Text('${snapshot.data[0].name}',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400))),
          Container(
              margin: EdgeInsets.only(top: 0.0, bottom:0.0),
              child:
              Text('${snapshot.data[0].email}',
                  style: TextStyle(color: Colors.white, fontSize: 10)))
        ]
    );} else {
    return Center(child: CircularProgressIndicator());
    }
  });
  }
}

class drop_icon extends StatefulWidget {
  @override
  State<drop_icon> createState() => drop_icon_state();
}

class drop_icon_state extends State<drop_icon> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(value: dropdownValue, icon: const Icon(Icons.arrow_downward), elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}