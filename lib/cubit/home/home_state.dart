part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class BottomSheetOpened extends HomeState {
  final double appBarHeight, appBarTitleFontSize, appBarIconSize;
  final double hamburgerMenuHeight,
      hamburgerMenuTileRadius,
      dateTimeHeight,
      dateTileRadius;
  final double bottomSheetHeight;
  final bool showCalenderIconInBottomSheet, openOpt;

  BottomSheetOpened({
    @required this.appBarHeight,
    @required this.appBarTitleFontSize,
    @required this.appBarIconSize,
    @required this.hamburgerMenuHeight,
    @required this.hamburgerMenuTileRadius,
    @required this.dateTimeHeight,
    @required this.dateTileRadius,
    @required this.bottomSheetHeight,
    @required this.showCalenderIconInBottomSheet,
    @required this.openOpt,
  });
}
