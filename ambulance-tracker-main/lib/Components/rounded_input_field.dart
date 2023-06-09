// @dart=2.9
import 'package:flutter/material.dart';
import 'package:ambulance_tracker/Components/text_field_container.dart';
import 'package:ambulance_tracker/constants.dart';

class RoundedInputField extends StatelessWidget {
  
  final String hintText;
  final IconData icon;
 final emailcontroller=TextEditingController();



  final ValueChanged<String> onChanged;
    RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: emailcontroller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
