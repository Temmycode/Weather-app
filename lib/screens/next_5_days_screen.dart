import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/clients/weather_api_client.dart';
import 'package:weather_app/models/future_weather_model.dart';
import 'package:weather_app/utils/dimension.dart';
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
  final WeahterApiClient _weather = WeahterApiClient();
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
                      right: Dimensions.width10,
                      top: Dimensions.height15,
                      left: Dimensions.width10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              height: Dimensions.height50,
                              width: Dimensions.width50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
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
                          height: Dimensions.height50,
                          width: Dimensions.width50,
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
                    height: Dimensions.height30,
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
                          SizedBox(
                              height: Dimensions.height30,
                              width: Dimensions.height30,
                              child: Image.network(
                                '${_data!.information![0].iconUrl}',
                                fit: BoxFit.fitHeight,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.height20,
                  ),
                  // weather information
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.width20),
                    height: Dimensions.height100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
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
                    height: Dimensions.height55,
                  ),

                  // next 10 days information
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.width20),
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
                              margin: const EdgeInsets.only(
                                  bottom: Dimensions.height15),
                              child: ListTile(
                                leading: Container(
                                  alignment: Alignment.centerLeft,
                                  width: Dimensions.width75,
                                  child: SmallText(
                                    text: formattedDate,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                title: Center(
                                  child: SizedBox(
                                    width: Dimensions.width100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SmallText(
                                          text:
                                              "${getDailyWeatherData()[index].tempMin!.ceil()}",
                                        ),
                                        Container(
                                          width: Dimensions.width40,
                                          height: Dimensions.height10,
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
                                trailing: SizedBox(
                                    height: Dimensions.height50,
                                    width: Dimensions.width50,
                                    child: Image.network(
                                      '${_data!.information![index].iconUrl}',
                                      fit: BoxFit.fitHeight,
                                    )),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            );
          } else {
            final spinKit = Center(
              child: SpinKitDoubleBounce(
                color: AppColors.blueishColor,
                size: Dimensions.height100,
              ),
            );
            return spinKit;
          }
        },
      ),
    );
  }
}
