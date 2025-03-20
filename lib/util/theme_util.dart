import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konesp/res/colors.dart';

class ThemeUtil {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        secondary: Colours.primary,
        error: Colors.red,
      ),
      primaryColor: Colours.primary,
      primaryColorLight: Colours.primary,
      dividerColor: Colours.bg,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      indicatorColor: Colours.primary,
      scaffoldBackgroundColor: Colours.bg,
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colours.primary;
          }
          return Colors.transparent;
        }),
        side: MaterialStateBorderSide.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return BorderSide(width: 1, color: Colors.transparent);
          }
          return BorderSide(width: 1, color: Colours.text_ccc);
        }),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colours.primary.withAlpha(70),
        selectionHandleColor: Colours.primary,
        cursorColor: Colours.primary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      dividerTheme: DividerThemeData(color: Colours.bg, space: 0.6, thickness: 0.6),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Colours.primary,
      ),
    );
  }
}
