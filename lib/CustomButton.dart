import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlocationupdate/LoginSelection.dart';
import 'package:flutterlocationupdate/colors.dart';


Widget customWidgetWithRoundedBorder(String buttonText,
    buttonClick buttonClickListener) {
  return RaisedButton(
    padding: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: rounded_border_color)
    ),
    onPressed: () async {
      buttonClickListener.buttonclick("Login");
    },
    child: Text(buttonText),
    textColor: text_color,
    color: button_fill_color,
  );
}
/*
Widget customTextFieldWthRectangleBorder(bool obscureText, String hintText,
    TextInputType mKeyboardType, IconData prefixIcon) {
  return TextField(
    obscureText: obscureText,
    decoration: new InputDecoration(
      prefixIcon: Icon(prefixIcon),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focused_border_color, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabled_border_color, width: 2.0),
      ),
      hintText: hintText,
    ),
    keyboardType: mKeyboardType,
  );
}*/

InputDecoration customTextFieldWthRectangleBorder(bool obscureText,
    String hintText,
    TextInputType mKeyboardType, IconData prefixIcon) {
  return new InputDecoration(
    prefixIcon: Icon(prefixIcon),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focused_border_color, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: enabled_border_color, width: 2.0),
    ),
    hintText: hintText,
  );
}


Widget CustomButton(String buttonText, String imageAsset,
    buttonClick buttonClickListener) {
  return RaisedButton.icon(
    icon: new Image.asset(imageAsset),
    onPressed: () {
      buttonClickListener.buttonclick("");
    },
    label: Text(buttonText),
    color: google_color,
    textColor: text_color,
  );
}