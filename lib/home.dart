import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/components/app_bar/app_bar.dart';
import 'package:weatherly/components/bottom_navigation/bottom_nav.dart';
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
      backgroundColor: Colors.deepPurple,
      body: BlocConsumer(
        cubit: _homeCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BottomSheetOpened) {
            _homeDimsModel = state.homeDimsModel;
          }
          return Stack(
            children: [
              (state is BottomNavigationOpened)
                  ? HomeBodyWidgetWithBottomNavigation(
                      homeCubit: _homeCubit,
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
              (state is BottomNavigationOpened)
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

class HomeBodyWidgetWithBottomNavigation extends StatefulWidget {
  final HomeCubit homeCubit;

  const HomeBodyWidgetWithBottomNavigation({Key key, @required this.homeCubit})
      : super(key: key);

  @override
  _HomeBodyWidgetWithBottomNavigationState createState() =>
      _HomeBodyWidgetWithBottomNavigationState();
}

class _HomeBodyWidgetWithBottomNavigationState
    extends State<HomeBodyWidgetWithBottomNavigation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _heightAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    )..forward();

    _heightAnimation = Tween<double>(
      begin: SizeConfig.heightMultiplier * 4,
      end: SizeConfig.heightMultiplier * 69,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _heightAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(
            milliseconds: 600,
          ),
          height: _heightAnimation.value,
          width: SizeConfig.widthMultiplier * 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                40,
              ),
            ),
          ),
        ),
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
