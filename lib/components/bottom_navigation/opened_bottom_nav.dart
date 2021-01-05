import 'package:flutter/material.dart';
import 'package:weatherly/size_conf.dart';

class OpenedBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        WeatherStateTile(
          location: 'Tehran',
          state: '2°',
          img: 'assets/images/cloudy.png',
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        CustomDevider(),
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        WeatherStateTile(
          location: 'London ',
          state: '4°',
          img: 'assets/images/foggy.png',
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        CustomDevider(),
        SizedBox(
          height: SizeConfig.heightMultiplier * 3,
        ),
        WeatherStateTile(
          location: 'Armenia',
          state: '0°',
          img: 'assets/images/snowy.png',
        ),
      ],
    );
  }
}

class CustomDevider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      height: .1,
      decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
          color: Colors.deepPurpleAccent.withOpacity(.5),
          blurRadius: 4,
          spreadRadius: .4,
        ),
      ]),
    );
  }
}

class WeatherStateTile extends StatelessWidget {
  final String location;
  final String state;
  final String img;

  const WeatherStateTile(
      {Key key,
      @required this.location,
      @required this.state,
      @required this.img})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            location,
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.w300),
          ),
          Text(
            state,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            img,
            width: SizeConfig.imageSizeMultiplier * 18,
          ),
        ],
      ),
    );
  }
}
