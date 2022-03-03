import 'package:flutter/material.dart';
import 'main.dart';
import 'services.dart';
import 'drawer.dart';

class login_screen extends StatelessWidget {

  static final _controller_name = TextEditingController();
  static final _controller_email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack( children:[
      Column( children:[
        Container( color: Colors.green, height: MediaQuery.of(context).size.width/5),
        Container( color: Colors.green, height: MediaQuery.of(context).size.width/4),
      ]),
      Padding (padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8,
          right: MediaQuery.of(context).size.width/8,
      top: MediaQuery.of(context).size.height/4.5), child:
    Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 3.0), borderRadius: BorderRadius.all(
            Radius.circular(8.0) //                 <--- border radius here
        ),
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5), spreadRadius: 5,
              blurRadius: 7, offset: Offset(0, 3),),],
        ),
      height: MediaQuery.of(context).size.height/1.85,
      width: MediaQuery.of(context).size.width/1.3,
      child:
    SingleChildScrollView( child:
      Column(
        children:[
      Padding (padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/15), child:
          Text('SING IN', textAlign: TextAlign.center, style: TextStyle(
            color: Colors.green,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ))),
        Padding (padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10), child:
          TextField(
              //enableInteractiveSelection: false,
            decoration: InputDecoration(
              labelText: 'Имя', labelStyle: TextStyle(fontSize: 13)),
            controller: _controller_email,
          )),
        Padding (padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10), child:
        TextField( decoration: InputDecoration(
            labelText: 'Почта', labelStyle: TextStyle(fontSize: 13)),
          controller: _controller_name,
        )),
        Padding( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/18,
            right: MediaQuery.of(context).size.width/18,
            top: MediaQuery.of(context).size.width/8), child:
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green[600], // background
              onPrimary: Colors.white,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),// foreground
            ),
        onPressed: ()async {
          DatabaseHandler handler;
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            User firstUser = User(name: '$_controller_name', email: '$_controller_email');
            List<User> listOfUsers = [firstUser];
            return await handler.insertUser(listOfUsers);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => main_app()));
        },
        child: Row(
            children: [
              Padding (padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/11)),
              Text('Войти', style: TextStyle(fontSize: 15))])))
        ]
      )
    )))]);
  }
}
