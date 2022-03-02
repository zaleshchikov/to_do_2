import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class model{
  int id;

  static fromMap() {}
  toMap() {}
}

class list_of_lists extends model{
  static String table = 'todo';
  int id;
  String list;
  String is_selected;
  list_of_lists({ this.list, this.id, this.is_selected});

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'list': list,
      'is_selected': is_selected
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static list_of_lists fromMap(Map<String, dynamic> map) {

    return list_of_lists(
        id: map['id'],
        list: map['list'],
        is_selected: map['is_selected']
    );
  }
}

abstract class db_list {

  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {

    if (_db != null) { return; }

    try {
      String _path = await getDatabasesPath() + 'examples';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate_page);
    }
    catch(ex) {
      print(ex);
    }
  }


  static void onCreate_page(Database db, int version) async =>
      await db.execute('CREATE TABLE todo(id INTEGER, list TEXT, is_selected TEXT)');

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert_page(String table, model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, model model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> update_page(String table, model model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> update_page_without_model(String table, model model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete_page(String table, model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

}

List lists_;//_ = [list_of_lists(list: ['Молоко', 'Сметана', 'Мёд']), list_of_lists(list: ['Молоко', 'Сметана', 'Мёд']), list_of_lists(list: ['Молоко', 'Сметана', 'Мёд'])];



