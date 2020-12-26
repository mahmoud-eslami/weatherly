import 'package:flutter/material.dart';
import 'package:weatherly/size_conf.dart';

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
                    width: SizeConfig.imageSizeMultiplier * 8,
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
                  width: SizeConfig.widthMultiplier * 38,
                  height: SizeConfig.heightMultiplier * 27,
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
                  width: SizeConfig.widthMultiplier * 38,
                  height: SizeConfig.heightMultiplier * 20,
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
