import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

/*class list_of_lists {
  static String table = 'tdo_items';
  int id;
  List<String> list = [];
  List<bool> is_selected = [];
  list_of_lists({@required this.list, this.id, this.is_selected});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'list': list,
      'is_selected': is_selected
    };
  }

  static list_of_lists fromMap(Map<String, dynamic> map) {

    return list_of_lists(
        id: map['id'],
        list: map['list'],
        is_selected: map['is_selected']
    );
  }
}*/


abstract class Model {

  int id;

  static fromMap() {}
  toMap() {}
}

class TodoItem extends Model {

  static String table = 'todo_items';

  int id;
  String task;
  bool complete;

  TodoItem({ this.id, this.task, this.complete });

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'task': task,
      'complete': complete
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static TodoItem fromMap(Map<String, dynamic> map) {

    return TodoItem(
        id: map['id'],
        task: map['task'],
        complete: map['complete'] == 1
    );
  }
}

abstract class DB {

  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {

    if (_db != null) { return; }

    try {
      String _path = await getDatabasesPath() + 'example';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    }
    catch(ex) {
      print(ex);
    }
  }


  static void onCreate(Database db, int version) async =>
      await db.execute('CREATE TABLE todo_items (id INTEGER PRIMARY KEY NOT NULL, task STRING, complete BOOLEAN)');

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

   /*Future<int> insertUser(List<TodoItem> users) async {
    int result = 0;
    for(var user in users){
      result = await _db.insert('todo_items', user.toMap());
    }
    return result;
  }

  static getAllClients() async {
    var res = await _db.query("todo_items");
    List<TodoItem> list =
    res.map((c) => TodoItem.fromMap(c)).toList();
    return list;
  }*/

}