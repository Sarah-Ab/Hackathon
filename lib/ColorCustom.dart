import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Color c  = Color(0xFF29CE8B);

int prim = c.value;
  Map <int, Color>color_ = {
    50: Color(0xFFA4A4BF),
    100: Color(0xFFA4A4BF),
    200: Color(0xFFA4A4BF),
    300: Color(0xFF9191B3),
    400: Color(0xFF7F7FA6),
    500: Color(0xFF181861),
    600: Color(0xFF6D6D99),
    700: Color(0xFF5B5B8D),
    800: Color(0xFF494980),
    900: Color(0xFFFC041A), // erreur
    1000: Color(0xFF222745),
  };
  MaterialColor colorCustom = MaterialColor(prim, color_);
