import 'package:flutter/material.dart';

import 'header.dart';
import 'list_todo_list.dart';
import 'page.dart';
import 'services_drawer.dart';
class SlideBarMenuContent_drawer extends StatefulWidget {

  @override
  _SlideBarMenuContentState createState() => _SlideBarMenuContentState();
}

class _SlideBarMenuContentState extends State<SlideBarMenuContent_drawer>{

  void _save_page(index) async {

    list_of_lists list = list_of_lists(list:list_page_task.join(' '), is_selected: list_page_bool.join(' '), id: index);
    if (list_page_task != []) {await db_list.update_page(list_of_lists.table, list);
    setState(() {} );
    refresh_page();}
  }

  void _insert_page(index) async {

    list_of_lists list = list_of_lists(list:null, is_selected: null, id: index);
    await db_list.insert_page(list_of_lists.table, list);
    refresh_page();
  }

  //List lists_ = [list_of_lists(list: ['Молоко', 'Сметана', 'Мёд']), list_of_lists(list: ['Молоко', 'Сметана', 'Мёд']), list_of_lists(list: ['Молоко', 'Сметана', 'Мёд'])];

  void refresh_page() async {
    List<Map<String, dynamic>> _results = await db_list.query(list_of_lists.table);
    lists_ = _results.map((item) => list_of_lists.fromMap(item)).toList();
    setState(() { });
  }


  final myController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  String _task;

  TodoItem item1 = TodoItem(task: 'Важно');
  TodoItem item2 = TodoItem(task: 'Мои планы');
  TodoItem item3 = TodoItem(task: 'Завтрашний день');
  List<TodoItem> _tasks = [TodoItem(task: 'Важно'), TodoItem(task: 'Мои планы'), TodoItem(task: 'Завтрашний день')];

  void refresh() async {
    List <Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    _tasks = (_results.map((item) => TodoItem.fromMap(item)).toList());print(_task);
    setState(() { });
  }

  void refresh_first() async {
    List <Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    _tasks = [TodoItem(task: 'Важно'), TodoItem(task: 'Мои планы'), TodoItem(task: 'Завтрашний день')];
    setState(() { });
  }

  void len() {
    if (lists_.length <= 10){
      for (int i = lists_.length-1;i <= 9; i++){
        lists_.add(list_of_lists(list:''));
      }
    }
  }

  @override
  void initState(){
    print(index_page);
    index_page != null? _save_page(index_page): null;
    refresh_page();
    refresh();
    len();
    super.initState();
    refresh();
  }


  List<String> lsitOfTask = ["Корова", "Молок","Мёд"];
  List <String> name_of_tile = ['Важно', 'Мои планы', 'Завтрашний день'];
  /*Widget make_page(ind){
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
  }*/


  List <IconData> icon_of_tile = [Icons.beach_access, Icons.add_a_photo, Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite,Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite, Icons.favorite];
  String _userToDo;


  void _save() async {
    if(_userToDo != null){
    TodoItem item = TodoItem(
        task: _userToDo,
    );

    await DB.insert(TodoItem.table, item);
    setState(() {
    } );
    refresh();}
  }

  void add_new_name() async{
    /*TodoItem item = TodoItem(
        task: _userToDo,
    );
    print(_userToDo);
    await DB.insert(TodoItem.table, item);*/
    setState(() {
      if(_userToDo != null){
        icon_of_tile.add(Icons.beach_access);
        name_of_tile.add(myController.text);}
      });
    }

  _update(index) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await

    // row to update
    list_of_lists list_2 = list_of_lists(list:list_page_task.join(' '), is_selected: list_page_bool.join(' '));

    // We'll update the first row just as an example
    dynamic result = await db_list.update_page(TodoItem.table, list_2);
    // do the update and get the number of affected rows

    // show the results: print all rows in the db
    print(db_list.query(list_of_lists.table));
  }



  @override
  Widget build(BuildContext context) {
    return
      Drawer(
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
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                          Row(
                              children: [
                                Text('${_tasks[index].task}',
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
                            index_page = index;
                            //lists_[index] = list_of_lists(list: list_page);
                            //_toggle(lists_[index]);
                            list_page_task = [];
                            list_page_bool = [];
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MaterialApp(
                                  home:
                                  Scaffold(
                                      appBar: AppBar(
                                        centerTitle: true,
                                        title: Text('${_tasks[index].task}'),
                                        backgroundColor: Colors.green[600],
                                      ),
                                      body:
                                      Home(todoList: lists_[index].list, isCheck: lists_[index].is_selected,),
                                      drawer: SlideBarMenuContent_drawer()
                                  )
                              ),)
                            );
                          },
                        );
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
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
          height: MediaQuery.of(context).size.height/4.5+6,
          child:
      Column(
        mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top:0),
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
                Padding(padding:  EdgeInsets.only(left:16),
                    child: Row(
                        children: [
                          Text('Выберете эмблему:', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                          Padding(padding:  EdgeInsets.only(left:6),
                              child: drop_icon())])),
                /*Row(
            children: [*/
                Container(
                    padding: const EdgeInsets.only(right: 68),
                    width: MediaQuery.of(context).size.width/1.8,
                    child:
                    Row(
                      children: [
                    Text('Цвет эмблемы:',style: TextStyle(color: Colors.grey[700], fontSize: 12), textAlign: TextAlign.center),
                    Container(color: Colors.green[600], height: 11, width: 15)
                      ])),
                /*Container(
                    width: MediaQuery.of(context).size.width/1.8,
                    child: Text('Цвет текста:',style: TextStyle(color: Colors.grey[700], fontSize: 12), textAlign: TextAlign.left))*/
              ]
          )
      )),
      actions: [
        TextButton(
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
        TextButton(
    style: ElevatedButton.styleFrom(
    primary: Colors.green[600], // background
      onPrimary: Colors.white,
      shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
      ),// foreground
    ),
                    child: Text("Сохранить"),
                    onPressed:  () {
      print(lists_.length);
                      _insert_page((lists_.length != null? lists_.length: 0));
                      _save();
                      add_new_name();
                      Navigator.pop(context);
                      myController.text = '';
                      _userToDo = null;
                    },
            )],
        //buttonPadding: EdgeInsets.zero
        );
    });},
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


class drop_icon extends StatefulWidget {
  @override
  State<drop_icon> createState() => drop_icon_state();
}

class drop_icon_state extends State<drop_icon> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 44,
        height: 50,
      child: DropdownButton<Item>(
      hint:  Icon(Icons.android,color: Colors.green[600], size: 20),
      onChanged: (Item Value) {
        setState(() {
        });
      },
      items: users.map((user) {
        return  DropdownMenuItem<Item>(
          value: user,
          child: Row(
            children: <Widget>[
              user.icon,
            ],
          ),
        );
      }).toList(),
    ));
  }
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

  List users = [
    const Item('Android',Icon(Icons.beach_access, color: Colors.green, size: 20)),
    const Item('Flutter',Icon(Icons.add_a_photo,color:  Colors.green, size: 20)),
    const Item('ReactNative',Icon(Icons.favorite,color:  Colors.green, size: 20)),
    const Item('iOS',Icon(Icons.flag,color:  Colors.green,size: 20)),
  ];