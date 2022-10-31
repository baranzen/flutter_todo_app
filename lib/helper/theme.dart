import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helper/colors.dart';
import 'package:hexcolor/hexcolor.dart';

appTheme() => ThemeData(
      primarySwatch: MaterialColor(
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
      ),
      primaryColor: HexColor('#BAD1C2'),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HexColor('FFF7E9'),
          shadows: [
            Shadow(
              color: ColorHepler.getColor(3),
              blurRadius: 5,
            ),
          ],
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
