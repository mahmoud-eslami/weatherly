import 'package:flutter/material.dart';

class HomeDimsModel {
  final double appBarHeight, appBarTitleFontSize, appBarIconSize;
  final double hamburgerMenuHeight,
      hamburgerMenuTileRadius,
      dateTimeHeight,
      dateTileRadius;
  final double bottomSheetHeight;
  final bool showCalenderIconInBottomSheet;

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
  });
}
