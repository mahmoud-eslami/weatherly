import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/components/app_bar/app_bar.dart';
import 'package:weatherly/components/bottom_navigation/bottom_nav.dart';
import 'package:weatherly/components/bottom_navigation/opened_bottom_nav.dart';
import 'package:weatherly/components/bottom_sheet/bottom_sheet.dart';
import 'package:weatherly/components/hamburger_menu/hamburger_menu.dart';
import 'package:weatherly/cubit/home/home_cubit.dart';
import 'package:weatherly/home_dims_model.dart';
import 'package:weatherly/size_conf.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeCubit _homeCubit;
  HomeDimsModel _homeDimsModel;

  @override
  void initState() {
    // initialize home dims
    _homeDimsModel = HomeDimsModel(
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
    );

    // initialize home bloc
    _homeCubit = HomeCubit();
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5a189a),
      body: BlocConsumer(
        cubit: _homeCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BottomSheetOpened) {
            _homeDimsModel = state.homeDimsModel;
          }
          return Stack(
            children: [
              if (state is BottomNavigationStateChanged)
                SunSetWidget(
                  position: state.sunsetPosition,
                ),
              (state is BottomNavigationStateChanged)
                  ? HomeBodyWidgetWithBottomNavigation(
                      homeCubit: _homeCubit,
                      height: state.height,
                    )
                  : HomeBodyWidget(
                      homeCubit: _homeCubit,
                      state: _homeDimsModel.showCalenderIconInBottomSheet,
                    ),
              CustomAppBar(
                height: _homeDimsModel.appBarHeight,
                iconSize: _homeDimsModel.appBarIconSize,
                titleFontSize: _homeDimsModel.appBarTitleFontSize,
              ),
              HamburgerMenu(
                spaceHeight: _homeDimsModel.hamburgerMenuSpaceHeight,
                hamburgerMenuHeight: _homeDimsModel.hamburgerMenuHeight,
                hamburgerMenuTileRadius: _homeDimsModel.hamburgerMenuTileRadius,
                dateTileRadius: _homeDimsModel.dateTileRadius,
                dateTimeHeight: _homeDimsModel.dateTimeHeight,
              ),
              (state is BottomNavigationStateChanged)
                  ? BottomNavigation(
                      homeCubit: _homeCubit,
                    )
                  : CustomBottomSheet(
                      homeCubit: _homeCubit,
                      height: _homeDimsModel.bottomSheetHeight,
                      calenderIcon:
                          _homeDimsModel.showCalenderIconInBottomSheet,
                    ),
            ],
          );
        },
      ),
    );
  }
}

class SunSetWidget extends StatelessWidget {
  final double position;

  const SunSetWidget({Key key, @required this.position}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: SizeConfig.widthMultiplier * 14,
      top: position,
      duration: Duration(
        milliseconds: 600,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/sunset.png',
            width: SizeConfig.imageSizeMultiplier * 13,
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 2,
          ),
          Text(
            '18:20',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 10,
          ),
          Image.asset(
            'assets/images/sunrise.png',
            width: SizeConfig.imageSizeMultiplier * 13,
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 2,
          ),
          Text(
            '06:20',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class HomeBodyWidgetWithBottomNavigation extends StatefulWidget {
  final HomeCubit homeCubit;
  final double height;

  const HomeBodyWidgetWithBottomNavigation({
    Key key,
    @required this.homeCubit,
    @required this.height,
  }) : super(key: key);

  @override
  _HomeBodyWidgetWithBottomNavigationState createState() =>
      _HomeBodyWidgetWithBottomNavigationState();
}

class _HomeBodyWidgetWithBottomNavigationState
    extends State<HomeBodyWidgetWithBottomNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(
          milliseconds: 600,
        ),
        height: widget.height,
        width: SizeConfig.widthMultiplier * 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              40,
            ),
          ),
        ),
        child: SingleChildScrollView(child: OpenedBottomNav()),
      ),
    );
  }
}

class HomeBodyWidget extends StatelessWidget {
  final HomeCubit homeCubit;
  final bool state;

  const HomeBodyWidget({
    Key key,
    @required this.homeCubit,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Container(
        height: size.height,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                top: (state)
                    ? SizeConfig.heightMultiplier * 27
                    : SizeConfig.heightMultiplier * 15,
                left: (state) ? 0 : SizeConfig.widthMultiplier * 15,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 600),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: (state)
                          ? SizeConfig.textMultiplier * 13
                          : SizeConfig.textMultiplier * 9,
                      fontWeight: FontWeight.w200),
                  child: Text(
                    '19°',
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                top: SizeConfig.heightMultiplier * 41,
                child: Visibility(
                  visible: state,
                  child: Text(
                    'Feels like 17°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                top: (state)
                    ? SizeConfig.heightMultiplier * 45
                    : SizeConfig.heightMultiplier * 17,
                child: Image.asset(
                  'assets/images/rainy.png',
                  width: 40,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                top: SizeConfig.heightMultiplier * 75,
                child: Text(
                  'Naples',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w200),
                ),
              ),
              Positioned(
                top: SizeConfig.heightMultiplier * 25,
                left: SizeConfig.widthMultiplier * 1,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: Image.asset(
                    'assets/images/woman.png',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
