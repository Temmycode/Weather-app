import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/clients/weather_api_client.dart';
import 'package:weather_app/models/future_weather_model.dart';
import 'package:weather_app/models/weather_model.dart';
import '../utils/app_colors.dart';
import '../utils/reusables.dart';
import '../utils/small_text.dart';
import '../utils/text.dart';

class Next5Days extends StatefulWidget {
  const Next5Days({super.key});

  @override
  State<Next5Days> createState() => _Next5DaysState();
}

class _Next5DaysState extends State<Next5Days> {
  FutureWeather? _data;
  WeahterApiClient _weather = WeahterApiClient();
  getFutureData() async {
    _data = await _weather.get5DayData();
  }

  @override
  void initState() {
    getFutureData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getFutureData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Column(
                children: [
                  // App bar
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      top: 15.0,
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.blueishColor.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.whiteColor.withOpacity(0.7),
                                size: 22,
                              )),
                        ),
                        AppText(
                          text: "${_data!.city!.name}",
                          size: 22,
                          weight: FontWeight.normal,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.blueishColor.withOpacity(0.2),
                          ),
                          child: Image.asset(
                            "assets/icon/menu.png",
                            color: AppColors.whiteColor.withOpacity(0.7),
                            scale: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // temperature information
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // temperature of the enviroment
                      AppText(
                        text: "${_data!.information![0].temp!.ceil()}°",
                        weight: FontWeight.bold,
                        size: 50,
                        letterspacing: 4.0,
                      ),
                      // the type of the weather
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(
                              text:
                                  "${_data!.information![0].weatherInfo![0].description}"),
                          Icon(
                            Icons.storm,
                            color: Colors.amber[200],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // weather information
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.blueishColor.withOpacity(0.15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        reuseableColumn("assets/icon/wind.png",
                            "${_data!.information![0].windSpeed} m/s", "Wind"),
                        reuseableColumn("assets/icon/water.png",
                            "${_data!.information![0].humidity}%", "Humidity"),
                        reuseableColumn('assets/icon/pressure.png',
                            "${_data!.information![0].pressure}", "Pressure"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //todays information
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 15.0),
                    child: ListTile(
                      leading: SmallText(
                        text: "Today",
                        color: AppColors.whiteColor,
                      ),
                      title: Center(
                        child: Container(
                          width: 100,
                          //alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text:
                                    "${_data!.information![0].tempMin!.ceil()}",
                              ),
                              Container(
                                width: 40,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.blueishColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              SmallText(
                                text:
                                    "${_data!.information![0].tempMax!.ceil()}",
                                color: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.sunny_snowing,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  // next 10 days information
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getnext5Days().length,
                          itemBuilder: (context, index) {
                            var weatherData = _data!.information;
                            List<Information> getDailyWeatherData() {
                              List<Information> dailyData = [];
                              // Initialize the first day with the first weather data
                              DateTime currentDay =
                                  DateTime.parse(weatherData![0].dtTxt!);
                              dailyData.add(weatherData[0]);
                              for (int i = 1; i < weatherData.length; i++) {
                                DateTime dateTime =
                                    DateTime.parse(weatherData[i].dtTxt!);
                                // If the current data's day is different from the previous data's day, add it to the list
                                if (dateTime.day != currentDay.day) {
                                  dailyData.add(weatherData[i]);
                                  currentDay = dateTime;
                                }
                              }
                              return dailyData;
                            }

                            var dateList = getnext5Days()[index];
                            var formattedDate =
                                DateFormat('EEEE').format(dateList);
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: ListTile(
                                leading: SmallText(
                                  text: formattedDate,
                                  color: AppColors.whiteColor,
                                ),
                                title: Center(
                                  child: Container(
                                    width: 100,
                                    //alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SmallText(
                                          text:
                                              "${getDailyWeatherData()[index].tempMin!.ceil()}",
                                        ),
                                        Container(
                                          width: 40,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.blueishColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        SmallText(
                                          text:
                                              "${getDailyWeatherData()[index].tempMax!.ceil()}",
                                          color: AppColors.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.sunny_snowing,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
