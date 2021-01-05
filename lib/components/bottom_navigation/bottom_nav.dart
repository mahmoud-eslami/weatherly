import 'package:flutter/material.dart';
import 'package:weatherly/cubit/home/home_cubit.dart';

class BottomNavigation extends StatefulWidget {
  final HomeCubit homeCubit;

  const BottomNavigation({Key key, @required this.homeCubit}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  HomeCubit _homeCubit;
  AnimationController _scaleAnimationController;
  AnimationController _animationController;
  Animation<double> _fadeAnimation;
  Animation<double> _scaleTransition;

  @override
  void initState() {
    _homeCubit = HomeCubit();

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
    _homeCubit.close();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(.2),
              blurRadius: 20,
              spreadRadius: 3,
            )
          ],
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
                  onPressed: () {
                    _homeCubit.bottomSheetListener(isOpenBar: false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
