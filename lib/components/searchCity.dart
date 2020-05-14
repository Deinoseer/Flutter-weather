import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          labelText: 'Enter City Name',
          labelStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
