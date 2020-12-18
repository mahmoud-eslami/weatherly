import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> openBottomSheet({@required bool isOpenBar}) async {
    if (isOpenBar) {
      emit(
        BottomSheetOpened(
          appBarHeight: 90,
          appBarTitleFontSize: 20,
          appBarIconSize: 30,
          hamburgerMenuHeight: 90,
          hamburgerMenuTileRadius: 40,
          dateTimeHeight: 90,
          dateTileRadius: 40,
          bottomSheetHeight: 500,
          showCalenderIconInBottomSheet: false,
        ),
      );
    } else {
      emit(
        BottomSheetOpened(
          appBarHeight: 110,
          appBarTitleFontSize: 24,
          appBarIconSize: 40,
          hamburgerMenuHeight: 90,
          hamburgerMenuTileRadius: 0,
          dateTimeHeight: 90,
          dateTileRadius: 40,
          bottomSheetHeight: 80,
          showCalenderIconInBottomSheet: true,
        ),
      );
    }
  }
}
