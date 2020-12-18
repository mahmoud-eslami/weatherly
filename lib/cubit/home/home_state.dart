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
  final bool showCalenderIconInBottomSheet;

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
  });

  @override
  List<Object> get props => [
        appBarHeight,
        appBarTitleFontSize,
        appBarIconSize,
        hamburgerMenuHeight,
        hamburgerMenuTileRadius,
        dateTimeHeight,
        dateTileRadius,
        bottomSheetHeight,
        showCalenderIconInBottomSheet
      ];

  @override
  String toString() {
    return 'BottomSheetOpened{appBarHeight: $appBarHeight,'
        ' appBarTitleFontSize: $appBarTitleFontSize,'
        ' appBarIconSize: $appBarIconSize,'
        ' hamburgerMenuHeight: $hamburgerMenuHeight,'
        ' hamburgerMenuTileRadius: $hamburgerMenuTileRadius,'
        ' dateTimeHeight: $dateTimeHeight,'
        ' dateTileRadius: $dateTileRadius,'
        ' bottomSheetHeight: $bottomSheetHeight,'
        ' showCalenderIconInBottomSheet: $showCalenderIconInBottomSheet}';
  }
}
