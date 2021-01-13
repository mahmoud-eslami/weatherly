import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/home_dims_model.dart';
import 'package:weatherly/size_conf.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> bottomSheetListener({@required bool isOpenBar}) async {
    if (isOpenBar) {
      emit(
        BottomSheetOpened(
          homeDimsModel: HomeDimsModel(
            appBarHeight: SizeConfig.heightMultiplier * 14,
            appBarTitleFontSize: SizeConfig.textMultiplier * 3.5,
            appBarIconSize: SizeConfig.imageSizeMultiplier * 10,
            hamburgerMenuHeight: SizeConfig.heightMultiplier * 20,
            hamburgerMenuTileRadius: 40,
            dateTimeHeight: 0,
            dateTileRadius: 40,
            bottomSheetHeight: SizeConfig.heightMultiplier * 75,
            showCalenderIconInBottomSheet: false,
            hamburgerMenuSpaceHeight: 0,
          ),
        ),
      );
    } else {
      emit(
        BottomSheetOpened(
          homeDimsModel: HomeDimsModel(
            appBarHeight: SizeConfig.heightMultiplier * 20,
            appBarTitleFontSize: SizeConfig.textMultiplier * 4.5,
            appBarIconSize: SizeConfig.imageSizeMultiplier * 12,
            hamburgerMenuHeight: SizeConfig.heightMultiplier * 15,
            hamburgerMenuTileRadius: 0,
            dateTimeHeight: SizeConfig.heightMultiplier * 15,
            dateTileRadius: 40,
            bottomSheetHeight: SizeConfig.heightMultiplier * 14,
            showCalenderIconInBottomSheet: true,
            hamburgerMenuSpaceHeight: SizeConfig.heightMultiplier * 15,
          ),
        ),
      );
    }
  }

  Future<void> bottomNavigationListener({@required bool isOpenAction}) async {
    if (isOpenAction) {
      emit(BottomNavigationStateChanged(
          height: SizeConfig.heightMultiplier,
          sunsetPosition: SizeConfig.heightMultiplier * 27));
      await Future.delayed(Duration(milliseconds: 100));
      emit(BottomNavigationStateChanged(
          height: SizeConfig.heightMultiplier * 69,
          sunsetPosition: SizeConfig.heightMultiplier * 22));
    } else {
      emit(BottomNavigationStateChanged(
          height: SizeConfig.heightMultiplier,
          sunsetPosition: SizeConfig.heightMultiplier * 27));
      await Future.delayed(Duration(milliseconds: 400));
      emit(
        BottomSheetOpened(
          homeDimsModel: HomeDimsModel(
            appBarHeight: SizeConfig.heightMultiplier * 20,
            appBarTitleFontSize: SizeConfig.textMultiplier * 4.5,
            appBarIconSize: SizeConfig.imageSizeMultiplier * 12,
            hamburgerMenuHeight: SizeConfig.heightMultiplier * 15,
            hamburgerMenuTileRadius: 0,
            dateTimeHeight: SizeConfig.heightMultiplier * 15,
            dateTileRadius: 40,
            bottomSheetHeight: SizeConfig.heightMultiplier * 14,
            showCalenderIconInBottomSheet: true,
            hamburgerMenuSpaceHeight: SizeConfig.heightMultiplier * 15,
          ),
        ),
      );
      // emit(BottomNavigationStateChanged(
      //     height: SizeConfig.heightMultiplier * 69,
      //     sunsetPosition: SizeConfig.heightMultiplier * 22));
    }
  }
}
