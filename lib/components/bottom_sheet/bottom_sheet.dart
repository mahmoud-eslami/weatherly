import 'package:flutter/material.dart';
import 'package:weatherly/components/bottom_sheet/bottom_sheet_content.dart';
import 'package:weatherly/cubit/home/home_cubit.dart';
import 'package:weatherly/size_conf.dart';

class CustomBottomSheet extends StatelessWidget {
  final double height;
  final bool calenderIcon;
  final HomeCubit homeCubit;

  const CustomBottomSheet({
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
        onTap: () {
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
