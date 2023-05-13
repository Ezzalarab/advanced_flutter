import 'package:flutter/cupertino.dart';

import 'colors_manager.dart';
import 'fonts_manager.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color fontColor,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

// Light Style

TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.light,
  Color fontColor = ColorManager.darkGrey,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

// Regular Style

TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.regular,
  Color fontColor = ColorManager.darkGrey,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

// Medium Style

TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.medium,
  Color fontColor = ColorManager.darkGrey,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

// SemiBold Style

TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.semiBold,
  Color fontColor = ColorManager.darkGrey,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}

// Bold Style

TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.bold,
  Color fontColor = ColorManager.darkGrey,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: fontColor,
  );
}
