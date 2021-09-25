import 'package:flutter/material.dart';

// Application Colors
int color1 = 0xFFCB576C;
int color2 = 0xFF4781BE;
int color3 = 0xFFEDA924;
int color4 = 0xFF8BBC25;
int color5 = 0xFFFFA057;
int color6 = 0xFF57CBB6;
int color7 = 0xFF595DA6;

// Text Input
InputDecoration buildInputDecoration(bool hasFocus, int color) {
  return InputDecoration(
      fillColor:
          hasFocus ? Color(color).withAlpha(40) : Colors.black.withAlpha(10),
      contentPadding: EdgeInsets.fromLTRB(15, -15, 15, 0),
      errorStyle: TextStyle(height: 0.1, fontSize: 0.1),
      counterText: '',
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus
                  ? Color(color).withAlpha(40)
                  : Colors.black.withAlpha(10))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus
                  ? Color(color).withAlpha(40)
                  : Colors.black.withAlpha(10))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus
                  ? Color(color).withAlpha(40)
                  : Colors.black.withAlpha(10))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus
                  ? Color(color).withAlpha(40)
                  : Colors.black.withAlpha(10))));
}

// Test Input Text Style
TextStyle textStyle(bool hasFocus, int color) {
  return TextStyle(color: hasFocus ? Color(color) : Colors.black54);
}
