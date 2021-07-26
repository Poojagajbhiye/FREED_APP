import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    //width & height of screen
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;

    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    //safe area (full screen width & height remove extra padding like appbar, status bar)
    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }

  static double dancingDoodleSize() {
    if (screenHeight! >= 600 && screenHeight! <= 700) {
      return blockSizeHorizontal! * 65;
    } else if (screenHeight! >= 701 && screenHeight! <= 800) {
      return blockSizeHorizontal! * 75;
    } else {
      return blockSizeHorizontal! * 80;
    }
  }

  static double rollerSkateDoodleSize() {
    if (screenHeight! >= 600 && screenHeight! <= 700) {
      return safeBlockHorizontal! * 100;
    } else if (screenHeight! >= 701 && screenHeight! <= 800) {
      return safeBlockHorizontal! * 110;
    } else {
      return safeBlockHorizontal! * 110;
    }
  }

  static double dragViewSize() {
    if (screenHeight! >= 600 && screenHeight! <= 700) {
      return blockSizeVertical! * 48.5;
    } else if (screenHeight! >= 701 && screenHeight! <= 800) {
      return blockSizeVertical! * 53;
    } else {
      return blockSizeVertical! * 55;
    }
  }
}
