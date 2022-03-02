import 'package:flutter/material.dart';
import 'checkbox.dart';
import 'drawer.dart';

int index_page;
List<String> list_page_task = [];
List<bool> list_page_bool = [];

class Home extends StatefulWidget {
  String todoList;
  String isCheck;
  int index;
  Home({this.todoList, this.isCheck, this.index});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();

  @override
  void initState(){
    super.initState();
    if ((widget.todoList != null) & (widget.todoList != ' ') & (widget.todoList != '')){
    list_page_task.addAll(widget.todoList.split(' '));
    list_page_bool.addAll(widget.isCheck.split(' ').map((value){
      return value == 'true'? true:false;
    }).toList());};
  }

  String _userToDo;


  @override
  Widget build(BuildContext context) {
    /*if (list_page_task == null) {
      list_page_task = ['Корова','Молоко','Сыр'];}
    if (list_page_bool == null) {
      list_page_bool = [false, false, false];}*/

    return Scaffold(
        backgroundColor: Colors.green,
          body: ListView.builder(
          itemCount: (list_page_task).length,
          itemBuilder: (BuildContext context, int index){
            return Dismissible(key: Key((list_page_task)[index]),
                child: Card(
                  child: ListTile(title: Text((list_page_task)[index]),
                  trailing: checkBoxClass(list_page_bool[index], index),
                  )
                ),
              onDismissed: (direction){
              setState(() {
                (list_page_bool).removeAt(index);
                (list_page_task).removeAt(index);
                print(list_page_bool);
                print(list_page_task);
              });
              },
            );
          }
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.green, size: 35.0),
          onPressed: (){ showDialog(context: context,
              builder: (BuildContext context){
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                  controller: _controller,
                onChanged: (String value){
                  _userToDo = value;
                },
              ),
                actions: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      if(_userToDo != null){
                        (list_page_bool).add(false);
                        (list_page_task).add(_userToDo);};
                      Navigator.of(context).pop();
                      _controller.text = '';
                      _userToDo = null;
                      print(list_page_bool);
                      print(list_page_task);
                    });
                  }, child: Text('Добавить')),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                    _controller.text = '';
                    _userToDo = null;
                  }, child: Text('Отмена'))
                ],
            );
              }
          );},
        ),
    );
  }
}


