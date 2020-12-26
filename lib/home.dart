import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              HomeBodyWidget(
                homeCubit: _homeCubit,
                state: _homeDimsModel.showCalenderIconInBottomSheet,
              ),
              AppBar(
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
                  : BottomSheet(
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

class BottomNavigation extends StatefulWidget {
  final HomeCubit homeCubit;

  const BottomNavigation({Key key, @required this.homeCubit}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  AnimationController _scaleAnimationController;
  AnimationController _animationController;
  Animation<double> _fadeAnimation;
  Animation<double> _scaleTransition;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _scaleTransition = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Interval(0, 1, curve: Curves.easeOut),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragDown: (val) {
        widget.homeCubit.bottomSheetListener(isOpenBar: false);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
              top: 8.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.pink,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                ScaleTransition(
                  scale: _scaleTransition,
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.pink,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        windStatus(),
        dailyWeatherStatus(),
      ],
    );
  }

  Widget dailyWeatherStatus() {
    return SizedBox(
      child: Stack(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${index + 10} : 00',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/cloud.png',
                    width: SizeConfig.imageSizeMultiplier * 11,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 2,
                  ),
                  Text(
                    '12°',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Container(
              height: .5,
              color: Colors.grey,
            ),
            itemCount: 8,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.deepPurple),
                  child: Image.asset(
                    'assets/images/sit_man.png',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 30,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.amber),
                  child: Image.asset(
                    'assets/images/stand_man.png',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget windStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/cloud.png',
              width: SizeConfig.imageSizeMultiplier * 10,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            Text(
              'Rainy with short\nstorms.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/wind.png',
              width: SizeConfig.imageSizeMultiplier * 10,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            Text(
              'Wind En\n8 km/h',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
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
          if (height > 200.0) {
            homeCubit.bottomSheetListener(isOpenBar: calenderIcon);
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            homeCubit.bottomSheetListener(
                                isOpenBar: calenderIcon);
                          },
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1,
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
                        Visibility(
                          visible: calenderIcon,
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              homeCubit.bottomNavigationListener();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BottomSheetContent(),
                  ],
                ),
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
      dateTileRadius,
      spaceHeight;

  const HamburgerMenu({
    Key key,
    @required this.hamburgerMenuHeight,
    @required this.hamburgerMenuTileRadius,
    @required this.dateTimeHeight,
    @required this.dateTileRadius,
    @required this.spaceHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                width: 70,
                height: spaceHeight,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(hamburgerMenuTileRadius)),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 600),
                width: 70,
                height: dateTimeHeight,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(dateTileRadius)),
                ),
                child: Center(
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
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
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            width: 70,
            height: hamburgerMenuHeight,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(hamburgerMenuTileRadius)),
            ),
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
      duration: Duration(milliseconds: 800),
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
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              height: iconSize,
              width: iconSize,
              child: Image.asset(
                'assets/images/cloud_sun.png',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 800),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3),
              child: Text(
                'What to wear',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
