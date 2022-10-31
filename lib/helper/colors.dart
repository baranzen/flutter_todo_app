import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorHepler {
  static Color getColor(dynamic color) {
    switch (color) {
      case 1:
        return HexColor('#BAD1C2');
      case 2:
        return HexColor('#C0D9C9');
      case 3:
        return MaterialColor(
          0xFFC0D9C9,
          <int, Color>{
            50: HexColor('#BAD1C2'),
            100: HexColor('#BAD1C2'),
            200: HexColor('#BAD1C2'),
            300: HexColor('#BAD1C2'),
            400: HexColor('#BAD1C2'),
            500: HexColor('#BAD1C2'),
            600: HexColor('#BAD1C2'),
            700: HexColor('#BAD1C2'),
            800: HexColor('#BAD1C2'),
            900: HexColor('#BAD1C2'),
          },
        );
      case 'white':
        return HexColor('#FFF7E9');
      default:
        return HexColor('#BAD1C2');
    }
  }
}
