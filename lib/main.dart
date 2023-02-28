import 'package:flutter/material.dart';
import 'package:weather_app/screens/next_5_days_screen.dart';
import 'package:weather_app/screens/present_location_weather.dart';
import 'package:weather_app/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.blackColor,
        primarySwatch: Colors.blue,
      ),
      home: const CurrentLocationweather(),
    );
  }
}
