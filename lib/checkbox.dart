import 'package:flutter/material.dart';

class checkBoxClass extends StatefulWidget {
  checkBoxClass({Key key}) : super(key: key);

  @override
  State<checkBoxClass> createState() => _checkBoxClassState();
}


class _checkBoxClassState extends State<checkBoxClass> {

  // This holds the state of the checkbox, we call setState and update this whenever a user taps the checkbox
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.white,
      checkColor: Colors.green,
      value: isChecked,
      onChanged: (bool value) { // This is where we update the state when the checkbox is tapped
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}
