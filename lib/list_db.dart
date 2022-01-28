import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class User{
  final String name;
  final String email;

  User({
    @required this.name,
    this.email});

  User.fromMap(Map<String, dynamic> res)
      :     name = res["name"],
        email = res["email"];

  Map<String, Object> toMap() {
    return {'name': name, 'email': email};}

  @override  String toString() {
    return 'Dog{name: $name, email: $email}';
  }

}

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(name TEXT NOT NULL, email TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var user in users){
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}