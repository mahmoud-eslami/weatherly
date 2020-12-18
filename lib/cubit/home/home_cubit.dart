import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/home_dims_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> bottomSheetListener({@required bool isOpenBar}) async {
    if (isOpenBar) {
      emit(
        BottomSheetOpened(
          homeDimsModel: HomeDimsModel(
            appBarHeight: 80,
            appBarTitleFontSize: 20,
            appBarIconSize: 30,
            hamburgerMenuHeight: 110,
            hamburgerMenuTileRadius: 40,
            dateTimeHeight: 0,
            dateTileRadius: 40,
            bottomSheetHeight: 500,
            showCalenderIconInBottomSheet: false,
            hamburgerMenuSpaceHeight: 0,
          ),
        ),
      );
    } else {
      emit(
        BottomSheetOpened(
          homeDimsModel: HomeDimsModel(
            appBarHeight: 120,
            appBarTitleFontSize: 27,
            appBarIconSize: 50,
            hamburgerMenuHeight: 90,
            hamburgerMenuTileRadius: 0,
            dateTimeHeight: 90,
            dateTileRadius: 40,
            bottomSheetHeight: 80,
            showCalenderIconInBottomSheet: true,
            hamburgerMenuSpaceHeight: 90,
          ),
        ),
      );
    }
  }
}
