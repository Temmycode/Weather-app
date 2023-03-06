import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/small_text.dart';
import 'app_colors.dart';
import 'dimension.dart';

Widget reuseableColumn(String image, String text, String smallText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset(
        image,
        scale: 20,
        //color: color,
      ),
      SmallText(
        text: text,
        size: 20,
        color: AppColors.whiteColor,
      ),
      SmallText(text: smallText),
    ],
  );
}

List<String> weatherOptions = [
  "Today",
  "Tomorrow",
  "Next 5 days",
];

String convertTime(String time) {
  final dateTime = DateFormat('HH:mm').parse(time);
  final format = DateFormat('h a');
  return format.format(dateTime);
}

Widget reusableContainer(String text, String image, String temperature) {
  text = text.substring(11, 18);
  text = convertTime(text);

  return Container(
    margin: const EdgeInsets.only(right: 10),
    height: 110,
    width: 80,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.blueishColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SmallText(
          text: text,
        ),
        SizedBox(
            height: Dimensions.height55,
            width: Dimensions.height55,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            )),
        SmallText(
          text: '$temperature°',
          weight: FontWeight.w600,
          color: AppColors.whiteColor,
        )
      ],
    ),
  );
}

List<DateTime> getnext5Days() {
  List<DateTime> next5Days = [];
  DateTime now = DateTime.now();

  for (int i = 0; i < 5; i++) {
    next5Days.add(now.add(Duration(days: i)));
  }
  return next5Days;
}
