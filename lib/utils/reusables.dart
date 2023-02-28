import 'package:flutter/material.dart';
import 'package:weather_app/utils/small_text.dart';
import 'app_colors.dart';

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

Widget reusableContainer(String text, IconData icon, String temperature) {
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
        Icon(icon),
        SmallText(
          text: temperature,
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
