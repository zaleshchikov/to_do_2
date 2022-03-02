import 'package:flutter/material.dart';
import 'page.dart';
class checkBoxClass extends StatefulWidget {
  bool isChecked;
  int index;
  checkBoxClass(this.isChecked, this.index);

  @override
  State<checkBoxClass> createState() => _checkBoxClassState();
}


class _checkBoxClassState extends State<checkBoxClass> {

  // This holds the state of the checkbox, we call setState and update this whenever a user taps the checkbox


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.white,
      checkColor: Colors.green,
      value: widget.isChecked,
      onChanged: (bool value) {
        list_page_bool[widget.index] = !list_page_bool[widget.index];
        setState(() {
          widget.isChecked = value;
        });
      },
    );
  }
}
