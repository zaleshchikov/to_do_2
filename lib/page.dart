import 'package:flutter/material.dart';
import 'checkbox.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  List todoList = [];
  @override
  void initState(){
    super.initState();
    todoList.addAll(['Корова', "Молоко"," Сыр"]);
  }
  String _userToDo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
        body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index){
          return Dismissible(key: Key(todoList[index]),
              child: Card(
                child: ListTile(title: Text(todoList[index]),
                trailing: checkBoxClass(),
                )
              ),
            onDismissed: (direction){
            setState(() {
              todoList.removeAt(index);
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
                    if(_userToDo != null){todoList.add(_userToDo);};
                    Navigator.of(context).pop();
                    _controller.text = '';
                    _userToDo = null;
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


