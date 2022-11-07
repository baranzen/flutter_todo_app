import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

buildSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: HexColor('#DEF5E5').withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        1,
      ),
      content: Text(message),
    ),
  );
}
