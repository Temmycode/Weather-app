import 'package:flutter/material.dart';
import 'package:weather_app/utils/small_text.dart';
import 'package:weather_app/utils/text.dart';

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
      AppText(
        text: text,
        size: 20,
      ),
      SmallText(text: smallText),
    ],
  );
}

List<String> weatherOptions = [
  "Today",
  "Tomorrow",
  "Next 10 days",
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
