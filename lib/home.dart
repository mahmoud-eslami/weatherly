import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          AppBar(),
          HamburgerMenu(),
        ],
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
    return Container(
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
