import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pasco_shipping/module_theme/pressistance/theme_preferences_helper.dart';

@injectable
class AppThemeDataService {
  static final PublishSubject<ThemeData> _darkModeSubject =
      PublishSubject<ThemeData>();

  Stream<ThemeData> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;

  AppThemeDataService(this._preferencesHelper);

  static Color get PrimaryColor {
    return Color(0xFF656565);
  }

  static Color get PrimaryDarker {
    return Color(0xFF2D7DFF);
  }

  static Color get AccentColor {
    return Color(0xFFF9AA05);
  }

  Future<ThemeData> getActiveTheme() async {
    var dark = await _preferencesHelper.isDarkMode();
    if (dark == true) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        accentColor: AccentColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          textTheme: TextTheme(),
          brightness: Brightness.dark,
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: AccentColor ,selectionColor: AccentColor,selectionHandleColor: AccentColor),
      );
    }
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryDarker,
      accentColor: AccentColor,
      appBarTheme: AppBarTheme(centerTitle: true, color: Colors.white),
        textSelectionTheme: TextSelectionThemeData(cursorColor: AccentColor ,selectionColor: AccentColor ,selectionHandleColor: AccentColor)
    );
  }

  Future<void> switchDarkMode(bool darkMode) async {
    if (darkMode) {
      await _preferencesHelper.setDarkMode();
    } else {
      await _preferencesHelper.setDayMode();
    }
    var activeTheme = await getActiveTheme();
    _darkModeSubject.add(activeTheme);
  }
}
