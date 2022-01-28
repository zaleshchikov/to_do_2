import 'package:flutter/material.dart';
import 'page.dart';
import 'pages/p1.dart';
import 'drawer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'services.dart';

class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class MyInheritedWidget extends StatefulWidget {

  MyInheritedWidget({
    Key key,
    this.child,
  }): super(key: key);

  final Widget child;

  @override
  MyInheritedWidgetState createState() => new MyInheritedWidgetState();

  static MyInheritedWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_MyInherited>()).data;
  }
}

class MyInheritedWidgetState extends State<MyInheritedWidget>{

  List <String> name_of_tile = ['Важно', 'Мои планы', 'Завтрашний день'];
  List <IconData> icon_of_tile = [Icons.beach_access, Icons.add_a_photo, Icons.favorite];

  void add_new_name()  {
    setState(() {
      icon_of_tile.add(Icons.beach_access);
      name_of_tile.add(myController.text);
    });
  }

  @override
  Widget build(BuildContext context){
    return new _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

class main_app extends StatefulWidget {

  @override
  _main_app_state createState() => _main_app_state();
}


class _main_app_state extends State<main_app>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Задачи на сегодня'),
            backgroundColor: Colors.green[600],
          ),
          body: App(),
          drawer:
          /*MyInheritedWidget(
              child:*/
              SlideBarMenuContent_drawer()
      ), // <- сюда надо будет добавить примеры из статьи
    );
  }
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MaterialApp(
          initialRoute: '/p1',
          routes: {
            '/p1':(BuildContext context) => main_app(),

          }
      ));
}

showAlertDialogCorrect(BuildContext context) {
  final MyInheritedWidgetState state = MyInheritedWidget.of(context);
  AlertDialog alert = AlertDialog(
    title: Text("Создать новый список", style: TextStyle(color: Colors.grey[800], fontSize: 15),
      textAlign: TextAlign.center,),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    content: input_form_state(),
    actions: [
      ElevatedButton(
        child: Text("Сохранить"),
        onPressed:  () {
          state.add_new_name();
          Navigator.pop(context);
          myController.text = '';
        },
      ),
      ElevatedButton(
        child: Text("Отменить"),
        onPressed:  () {
          Navigator.pop(context);
          myController.text = '';
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class input_form_state extends StatefulWidget{
  @override
  State<input_form_state> createState() => input_form();
}

final myController = TextEditingController();

class input_form extends State<input_form_state>{
  FocusNode myFocusNode = FocusNode();

  /*@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: MediaQuery.of(context).size.height/3.7,
          child:
          Column(
              children: [
                TextFormField(
                controller: myController,
                focusNode: myFocusNode,
                decoration: InputDecoration(focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    labelText: 'Наименование',
                    labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.grey : Colors.grey)),),
                Padding(padding:  EdgeInsets.only(left:6),
                    child: Row(
                        children: [
                          Text('Выберете эмблему:', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                          Padding(padding:  EdgeInsets.only(left:16),
                              child: MyStatefulWidget())])),
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
      );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return  Home();
  }
}

class SlideBarMenuContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
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
                      itemCount: state.name_of_tile.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                          Row(
                              children: [
                                Text('${state.name_of_tile[index]}',
                                    style: TextStyle(color: Colors.green, fontSize: 15)
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left:6),
                                    child: Icon(
                                      state.icon_of_tile[index],
                                      color: Colors.green,
                                      size: 18.0,
                                    )),
                              ]),
                          onTap: () {
                          },
                        );
                      }),
                  add_button()
                ])));
  }}

class add_button extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            showAlertDialogCorrect(context);
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
    );
  }
}

class Header extends StatelessWidget{

  String user_email = 'zaleshchikovaa@gmail.com';
  String user_name = 'Сашок';

  @override
  Widget build(BuildContext context) {
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
              Text('${this.user_name}',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400))),
          Container(
              margin: EdgeInsets.only(top: 0.0, bottom:0.0),
              child:
              Text('${this.user_email}',
                  style: TextStyle(color: Colors.white, fontSize: 10)))
        ]
    );
  }
}

class MyStatefulWidget extends StatefulWidget {

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
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
