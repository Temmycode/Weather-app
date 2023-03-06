import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weather_app/clients/weather_api_client.dart';
import 'package:weather_app/models/future_weather_model.dart';
import 'package:weather_app/screens/next_5_days_screen.dart';
import 'package:weather_app/screens/tomorrow_screen.dart';
import 'package:weather_app/utils/dimension.dart';
import '../models/weather_model.dart';
import '../utils/app_colors.dart';
import '../utils/reusables.dart';
import '../utils/small_text.dart';
import '../utils/text.dart';

class CurrentLocationweather extends StatefulWidget {
  const CurrentLocationweather({super.key});

  @override
  State<CurrentLocationweather> createState() => _CurrentLocationweatherState();
}

class _CurrentLocationweatherState extends State<CurrentLocationweather> {
  int _index = 0;
  WeahterApiClient client = WeahterApiClient();
  Weather? data;
  FutureWeather? futureData;

  String formattedDate = DateFormat('d MMMM, EEEE').format(DateTime.now());

  Future<void> _handleRefresh() async {
    // setState(() {});
    await client.getData();
    await client.get3HoursData();
    return await Future.delayed(const Duration(seconds: 2));
  }

  // to get the api for the current weather
  Future _getData() async {
    data = await client.getData();
  }

  // to get the api data for the various time changes
  Future _get3HourTimeInterval() async {
    futureData = await client.get3HoursData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([_getData(), _get3HourTimeInterval()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LiquidPullToRefresh(
                color: AppColors.blueishColor,
                backgroundColor: AppColors.blackColor,
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                height: Dimensions.height120,
                onRefresh: _handleRefresh,
                child: ListView(
                  children: [
                    // app bar
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Dimensions.height10,
                        top: Dimensions.height15,
                        left: Dimensions.height10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "${data!.cityName}",
                                size: 22,
                                weight: FontWeight.normal,
                              ),
                              SmallText(text: formattedDate),
                            ],
                          ),
                          Container(
                            height: Dimensions.height50,
                            width: Dimensions.width50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              color: AppColors.blueishColor.withOpacity(0.2),
                            ),
                            child: Image.asset(
                              "assets/icon/menu.png",
                              color: AppColors.whiteColor.withOpacity(0.7),
                              scale: Dimensions.height25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.height20,
                    ),
                    SizedBox(
                      // size of the weather of the location informantion
                      height: Dimensions.height90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.width20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // temperature of the enviroment
                                AppText(
                                  text: "${data!.temp!.ceil()}°",
                                  weight: FontWeight.bold,
                                  size: Dimensions.height50,
                                  letterspacing: 2.0,
                                ),
                                // the type of the weather
                                SmallText(
                                    text:
                                        "${data!.weather!.toList()[0].description}"),
                              ],
                            ),
                            // icon for the weather
                            SizedBox(
                                height: Dimensions.height200,
                                width: Dimensions.height150,
                                child: Image.network(
                                  '${data!.iconUrl}',
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                      ),
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.height15),
                        color: AppColors.blueishColor.withOpacity(0.15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          reuseableColumn("assets/icon/wind.png",
                              "${data!.wind} m/s", "Wind"),
                          reuseableColumn("assets/icon/water.png",
                              "${data!.humidity}%", "Humidity"),
                          reuseableColumn('assets/icon/pressure.png',
                              "${data!.pressure}", "Pressure"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.height25,
                    ),
                    // creating the tab view for the different options using a list view builder
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.width20),
                      height: Dimensions.height50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherOptions.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _index = index;
                                });
                                if (_index == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const TomorrowWeather()));
                                  _index = 0;
                                  setState(() {});
                                } else if (_index == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Next5Days()));
                                  _index = 0;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: Dimensions.width20),
                                height: Dimensions.height20,
                                child: Column(
                                  children: [
                                    Text(
                                      weatherOptions[index],
                                      style: GoogleFonts.chakraPetch(
                                          textStyle: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: _index == index ? FontWeight.bold : FontWeight.normal,
                                        color: _index == index
                                            ? AppColors.whiteColor
                                                .withOpacity(0.9)
                                            : AppColors.whiteColor
                                                .withOpacity(0.5),
                                      )),
                                    ),
                                    AppText(text: _index == index ? "." : ""),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: Dimensions.height15,
                    ),
                    // items for the today tab bar
                    // display it with a listview
                    Container(
                      margin: const EdgeInsets.only(left: Dimensions.width20),
                      height: Dimensions.height120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: futureData!.cnt,
                          itemBuilder: (context, index) {
                            return reusableContainer(
                                futureData!.information![index].dtTxt!,
                                futureData!.information![index].iconUrl!,
                                futureData!.information![index].temp!
                                    .ceil()
                                    .toString());
                          }),
                    ),
                    const SizedBox(
                      height: Dimensions.height25,
                    ),
                    // a container containing the map of the current location
                    Container(
                      height: Dimensions.height220,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.height20),
                      decoration: BoxDecoration(
                        color: AppColors.blueishColor.withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.height20,
                    )
                  ],
                ),
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
