import 'package:flutter/material.dart';
import 'package:cevotheapp/app/constans/app_constants.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
        fontFamily: Font.poppins,
        primaryColorDark: Color.fromARGB(255, 238, 174, 64),
        primaryColor: Color.fromARGB(255, 238, 174, 64),
        primaryColorLight: Color.fromARGB(255, 238, 174, 64),
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 238, 174, 64),
        ).merge(
          ButtonStyle(elevation: MaterialStateProperty.all(0)),
        )),
        canvasColor: Color.fromARGB(255, 255, 255, 255),
        cardColor: Color.fromARGB(255, 206, 207, 212),
      );

  // you can add other custom theme in this class like  light theme, dark theme ,etc.

  // example :
  // static ThemeData get light => ThemeData();

  // static ThemeData get dark => ThemeData();
}
