import 'package:flutter/material.dart';
import 'services.dart';


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
                            backgroundColor: Colors.white,
                            child:
                            Image.asset("cole-waiting.png")
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