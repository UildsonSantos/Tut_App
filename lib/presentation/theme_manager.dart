import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_manager.dart';
import 'package:tut_app/presentation/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    // will be used in case of disabled button for example
    accentColor: ColorManager.grey,

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

      // App bar theme

      // Button theme

      // Text theme

      // input decoration theme (text form field)

      );
}
