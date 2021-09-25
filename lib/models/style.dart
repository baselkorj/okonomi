import 'package:flutter/material.dart';

// Application Colors
const color1 = const Color(0xFFCB576C);
const color2 = const Color(0xFF4781BE);
const color3 = const Color(0xFFEDA924);
const color4 = const Color(0xFF8BBC25);
const color5 = const Color(0xFFFFA057);
const color6 = const Color(0xFF57CBB6);
const color7 = const Color(0xFF595DA6);

List<Color> gradient1 = [Color(0xFF65C7F7), Color(0xFF3a7bd5)];
List<Color> gradient2 = [Color(0xFFFBB040), Color(0xFFEF4136)];
List<Color> gradient3 = [Color(0xFFF9ED32), Color(0xFFFBB040)];
List<Color> gradient4 = [Color(0xFFFCCF31), Color(0xFFF55555)];

// Text Input
InputDecoration buildInputDecoration(bool hasFocus, int color) {
  return InputDecoration(
      fillColor:
          hasFocus ? Color(color).withAlpha(40) : Colors.black.withAlpha(10),
      contentPadding: EdgeInsets.fromLTRB(15, -15, 15, 0),
      errorStyle: TextStyle(height: 0),
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
