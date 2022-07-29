import 'package:flutter/material.dart';

Widget email_field(TextEditingController controller, hinttext, type) {
  return TextFormField(
    // selectionWidthStyle: BoxWidthStyle.tight,
    validator: (value) {
      if (value!.isEmpty) {
        return "must enter email here";
      }
    },
    keyboardType: type == "phone" ? TextInputType.number : TextInputType.text,
    controller: controller,
    //keyboardType: TextInputType.number,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white, fontSize: 15),
    decoration: InputDecoration(
      filled: true,
      label: Text(hinttext.toString(),
          style: TextStyle(
              color: Colors.black,
              //  fontFamily: mainFontFamily,
              fontSize: 22)),
      // labelStyle: TextStyle(
      //   color: kPrimaryColor,
      //   fontSize: 12,
      // ),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
    ),
  );
}
