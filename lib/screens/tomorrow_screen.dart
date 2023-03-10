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

class TomorrowWeather extends StatefulWidget {
  const TomorrowWeather({super.key});

  @override
  State<TomorrowWeather> createState() => _TomorrowWeatherState();
}

class _TomorrowWeatherState extends State<TomorrowWeather> {
  WeahterApiClient client = WeahterApiClient();
  FutureWeather? data;
  FutureWeather? tommorrow;

  String formattedDate = DateFormat('d MMMM, EEEE')
      .format(DateTime.now().add(const Duration(days: 1)));

  Future _getData() async {
    data = await client.get5DayData();
  }

  Future _getTomorrowData() async {
    tommorrow = await client.getTomorrowData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([_getData(), _getTomorrowData()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  // app bar
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      top: 15.0,
                      left: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "${data!.city!.name}",
                              size: 22,
                              weight: FontWeight.normal,
                            ),
                            SmallText(text: formattedDate),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.blueishColor.withOpacity(0.2),
                            ),
                            child: Image.asset(
                              "assets/icon/close.png",
                              color: AppColors.whiteColor.withOpacity(0.7),
                              scale: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    // size of the weather of the location informantion
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // temperature of the enviroment
                              AppText(
                                text: "${data!.information![9].temp!.ceil()}??",
                                weight: FontWeight.bold,
                                size: 50,
                                letterspacing: 2.0,
                              ),
                              // the type of the weather
                              SmallText(
                                  text:
                                      "${data!.information![9].weatherInfo![0].description}"),
                            ],
                          ),
                          // icon for the weather
                          Container(
                              height: 200,
                              width: 150,
                              child: Image.network(
                                '${data!.information![0].iconUrl}',
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ),
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
                            "${data!.information![9].windSpeed} m/s", "Wind"),
                        reuseableColumn("assets/icon/water.png",
                            "${data!.information![9].humidity}%", "Humidity"),
                        reuseableColumn('assets/icon/pressure.png',
                            "${data!.information![9].pressure}", "Pressure"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // creating the tab view for the different options using a list view builder
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 20),
                  //   height: 50,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: weatherOptions.length,
                  //       itemBuilder: (context, index) {
                  //         return GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               _index = index;
                  //             });
                  //             if (_index == 0) {
                  //               Navigator.of(context).pop();
                  //             } else if (_index == 2) {
                  //               Navigator.of(context).push(MaterialPageRoute(
                  //                   builder: (context) => const Next5Days()));
                  //               _index = 0;
                  //               setState(() {});
                  //             }
                  //           },
                  //           child: Container(
                  //             margin: const EdgeInsets.only(right: 20),
                  //             height: 20,
                  //             child: Column(
                  //               children: [
                  //                 Text(
                  //                   weatherOptions[index],
                  //                   style: GoogleFonts.chakraPetch(
                  //                       textStyle: TextStyle(
                  //                     fontSize: 16,
                  //                     //fontWeight: _index == index ? FontWeight.bold : FontWeight.normal,
                  //                     color: _index == index
                  //                         ? AppColors.whiteColor
                  //                             .withOpacity(0.9)
                  //                         : AppColors.whiteColor
                  //                             .withOpacity(0.5),
                  //                   )),
                  //                 ),
                  //                 AppText(text: _index == index ? "." : ""),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  // items for the today tab bar
                  // display it with a listview
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tommorrow!.cnt,
                        itemBuilder: (context, index) {
                          // var weatherData = futureData!.information;
                          // List<Information> getDailyWeatherData() {
                          //   List<Information> dailyData = [];
                          //   // Initialize the first day with the first weather data
                          //   DateTime currentDay =
                          //       DateTime.parse(weatherData![0].dtTxt!);
                          //   dailyData.add(weatherData[0]);
                          //   for (int i = 1; i < weatherData.length; i++) {
                          //     DateTime dateTime =
                          //         DateTime.parse(weatherData[i].dtTxt!);
                          //     // If the current data's day is different from the previous data's day, add it to the list
                          //     if (dateTime.day != currentDay.day) {
                          //       dailyData.add(weatherData[i]);
                          //       currentDay = dateTime;
                          //     }
                          //   }
                          //   return dailyData;
                          // }

                          // var
                          return reusableContainer(
                              tommorrow!.information![index].dtTxt!,
                              tommorrow!.information![index].iconUrl!,
                              tommorrow!.information![index].temp!
                                  .ceil()
                                  .toString());
                        }),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // a container containing the map of the current location
                  Container(
                    height: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.blueishColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            } else {
              final spinKit = SpinKitDoubleBounce(
                color: AppColors.blueishColor,
                size: Dimensions.height100,
              );
              return spinKit;
            }
          },
        ),
      ),
    );
  }
}
