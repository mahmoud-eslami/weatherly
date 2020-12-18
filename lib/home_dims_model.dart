import 'package:flutter/material.dart';

class HomeDimsModel {
  double appBarHeight, appBarTitleFontSize, appBarIconSize;
  double hamburgerMenuHeight,
      hamburgerMenuTileRadius,
      dateTimeHeight,
      dateTileRadius,
      hamburgerMenuSpaceHeight;
  double bottomSheetHeight;
  bool showCalenderIconInBottomSheet;

  HomeDimsModel({
    @required this.appBarHeight,
    @required this.appBarTitleFontSize,
    @required this.appBarIconSize,
    @required this.hamburgerMenuHeight,
    @required this.hamburgerMenuTileRadius,
    @required this.dateTimeHeight,
    @required this.dateTileRadius,
    @required this.bottomSheetHeight,
    @required this.showCalenderIconInBottomSheet,
    @required this.hamburgerMenuSpaceHeight,
  });
}
