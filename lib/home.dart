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

  @override
  void initState() {
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
          return Stack(
            children: [
              AppBar(),
              HamburgerMenu(),
              BottomSheet(),
            ],
          );
        },
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  var bottomSheetHeight;

  @override
  void initState() {
    bottomSheetHeight = 80.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onVerticalDragDown: (value) {
          if (bottomSheetHeight > 80.0) {
            setState(() {
              bottomSheetHeight = 80.0;
            });
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1100),
          curve: Curves.fastOutSlowIn,
          width: size.width,
          height: bottomSheetHeight,
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
                      setState(() {
                        bottomSheetHeight = 520.0;
                      });
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
                    visible: !(bottomSheetHeight > 90),
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
      ),
    );
  }
}

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 85,
        height: 180,
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
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40)),
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
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: size.width,
      height: 110,
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
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'What to wear',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
