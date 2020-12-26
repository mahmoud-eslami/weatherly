import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double height, iconSize, titleFontSize;

  const CustomAppBar({
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
