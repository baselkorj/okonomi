import 'package:flutter/material.dart';
import 'package:okonomi/models/global.dart';

// Application Colors
int color1 = 0xFFCB576C;
int color2 = 0xFF4781BE;
int color3 = 0xFFEDA924;
int color4 = 0xFF8BBC25;
int color5 = 0xFFFFA057;
int color6 = 0xFF57CBB6;
int color7 = 0xFF595DA6;
int color8 = 0xFFB0B0B0;
int color9 = 0xFFA8A8A8;
int color10 = 0xFFEBEBEB;

void updateStyle() {
  if (isDark.value) {
    color8 = 0xFFB0B0B0;
    color9 = 0xFFA8A8A8;
    color10 = 0xFF3A3A3A;
  } else {
    color8 = 0xFF898989;
    color9 = 0xFF222222;
    color10 = 0xFFEBEBEB;
  }
}

// Text Input
InputDecoration buildInputDecoration(bool hasFocus, int color) {
  return InputDecoration(
      fillColor: hasFocus ? Color(color).withAlpha(40) : Color(color10),
      contentPadding: EdgeInsets.fromLTRB(15, -15, 15, 0),
      errorStyle: TextStyle(height: 0.1, fontSize: 0.1),
      counterText: '',
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus ? Color(color).withAlpha(40) : Color(color10))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus ? Color(color).withAlpha(40) : Color(color10))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus ? Color(color).withAlpha(40) : Color(color10))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 0,
              color: hasFocus ? Color(color).withAlpha(40) : Color(color10))));
}

// Test Input Text Style
TextStyle textStyle(bool hasFocus, int color) {
  return TextStyle(color: hasFocus ? Color(color) : Color(color8));
}
