import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/cubit/home/home_cubit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeCubit _homeCubit;
  double appBarHeight, appBarTitleFontSize, appBarIconSize;
  double hamburgerMenuHeight,
      hamburgerMenuTileRadius,
      dateTimeHeight,
      dateTileRadius;
  double bottomSheetHeight;
  bool showCalenderIconInBottomSheet;

  @override
  void initState() {
    // bottomSheet
    bottomSheetHeight = 80;
    showCalenderIconInBottomSheet = true;

    // hamburgerMenu
    hamburgerMenuHeight = 90;
    hamburgerMenuTileRadius = 0;
    dateTimeHeight = 90;
    dateTileRadius = 40;

    // appBar
    appBarHeight = 110;
    appBarTitleFontSize = 24;
    appBarIconSize = 40;

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
      backgroundColor: Colors.deepPurple,
      body: BlocConsumer(
        cubit: _homeCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BottomSheetOpened) {
            // bottomSheet
            bottomSheetHeight = state.bottomSheetHeight;
            showCalenderIconInBottomSheet = state.showCalenderIconInBottomSheet;

            // hamburgerMenu
            hamburgerMenuHeight = state.hamburgerMenuHeight;
            hamburgerMenuTileRadius = state.hamburgerMenuTileRadius;
            dateTimeHeight = state.dateTimeHeight;
            dateTileRadius = state.dateTileRadius;

            // appBar
            appBarHeight = state.appBarHeight;
            appBarTitleFontSize = state.appBarTitleFontSize;
            appBarIconSize = state.appBarIconSize;
          }
          return Stack(
            children: [
              AppBar(
                height: appBarHeight,
                iconSize: appBarIconSize,
                titleFontSize: appBarTitleFontSize,
              ),
              HamburgerMenu(
                hamburgerMenuHeight: hamburgerMenuHeight,
                hamburgerMenuTileRadius: hamburgerMenuTileRadius,
                dateTileRadius: dateTileRadius,
                dateTimeHeight: dateTimeHeight,
              ),
              BottomSheet(
                homeCubit: _homeCubit,
                height: bottomSheetHeight,
                calenderIcon: showCalenderIconInBottomSheet,
              ),
            ],
          );
        },
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  final double height;
  final bool calenderIcon;
  final HomeCubit homeCubit;

  const BottomSheet({
    Key key,
    @required this.height,
    @required this.calenderIcon,
    @required this.homeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onVerticalDragDown: (value) {
          if (height > 80.0) {}
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1100),
          curve: Curves.fastOutSlowIn,
          width: size.width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      homeCubit.openBottomSheet(isOpenBar: calenderIcon);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Today\'s changes',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3),
                    ),
                  ),
                  // todo : add opacity animation to this part
                  Visibility(
                    visible: calenderIcon,
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HamburgerMenu extends StatelessWidget {
  final double hamburgerMenuHeight,
      hamburgerMenuTileRadius,
      dateTimeHeight,
      dateTileRadius;

  const HamburgerMenu({
    Key key,
    @required this.hamburgerMenuHeight,
    @required this.hamburgerMenuTileRadius,
    @required this.dateTimeHeight,
    @required this.dateTileRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Container(
            width: 85,
            height: 90,
            color: Colors.pinkAccent,
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.menu_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {}),
            ),
          ),
          // todo : check here u can use visibility widget
          Container(
            width: 85,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3),
                ),
                Text(
                  '03',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  final double height, iconSize, titleFontSize;

  const AppBar({
    Key key,
    @required this.height,
    @required this.iconSize,
    @required this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: size.width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/images/cloud_sun.png',
              height: iconSize,
              width: iconSize,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'What to wear',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
