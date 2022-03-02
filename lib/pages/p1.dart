import 'package:flutter/material.dart';
import '../page.dart';
import 'package:to_do_2/drawer.dart';
import 'package:to_do_2/services_drawer.dart';

class page1 extends StatefulWidget {

  String name;
  page1(this.name);

  @override
  _page1State createState() => _page1State();
}


class _page1State extends State<page1> {

  /*DB helper = DB();

  Future<int> addUsers() async {
    TodoItem firsItem = TodoItem(task: 'Milk', complete: true);
    TodoItem secondItem = TodoItem(task: 'Milk', complete: true);
    TodoItem threeItem = TodoItem(task: 'Milk', complete: true);
    List<TodoItem> listOfUsers = [firsItem, secondItem, threeItem];
    return await this.helper.insertUser(listOfUsers);
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home:
     Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text('${widget.name}'),
         backgroundColor: Colors.green[600],
       ),
        body:
  Home(),
       drawer: SlideBarMenuContent_drawer()
        )
    );
  }
}
