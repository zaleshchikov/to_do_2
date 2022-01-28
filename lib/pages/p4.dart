import 'package:flutter/material.dart';
import '../page.dart';
import 'package:to_do_2/drawer.dart';

class page4 extends StatelessWidget {

  String name;
  page4(this.name);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('$name'),
              backgroundColor: Colors.green[600],
            ),
            body: Home(),
            drawer: SlideBarMenuContent_drawer()
        )
    );
  }
}
