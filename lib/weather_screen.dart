import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Additionalinfo.dart';
import 'hourly_forecast.dart';
import 'package:http/http.dart' as http;

// note container does not have elevation property
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurentWeather();
  }

  Future<Map<String, dynamic>> getCurentWeather() async {
    // can be kept as future though
    // this is part of error handling
    try {
      String city = 'jodhpur';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city,in&APPID=29eb7ac84d38166c5ce73e0b0d2cb77b',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            // we can use Gesturedectetor or Inkwell to set the icon but we have to take care of the padding issue in case of Iconbutton the padding is done automatically //
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future:
            getCurentWeather(), // it lets u know what future value u will get in the app
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          // snapshot lets u know the current state of your app which is connection ,error, loading,data
          final data = snapshot.data!;

          final currentTemp = data['list'][0]['main']['temp'];
          final currentsky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindspeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // main card which we see now
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(
                                  '$currentTemp K',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Icon(
                                  currentsky == 'Clouds' || currentsky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  '$currentsky',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          20), // help to maintain size between to sized boxes
                  // weather forecast card
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hourly forecast',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.cloud,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.beach_access_sharp,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.air_rounded,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.cloud,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.sunny_snowing,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //       SizedBox(
                  //         width: 100,
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: const hourlyForecastItem(
                  //               s1: '03:00',
                  //               icon: Icons.sunny,
                  //               s2: '320.12',
                  //             )),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlysky =
                            data['list'][index + 1]['weather'][0]['main'];
                        final hourlytemp =
                            hourlyForecast['main']['temp'].toString();
                        final time = DateTime.parse(hourlyForecast[
                            'dt_txt']); // this is done to get the time from a string
                        return hourlyForecastItem(
                          s1: DateFormat.j().format(
                              time), // this is functionality of intl package provided by flutter
                          icon: hourlysky == 'Clouds' || hourlysky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          s2: hourlytemp,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height:
                          8), // help to maintain size between to sized boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // it automatically adjust the space around it  so it looks descent
                    children: [
                      Additionalinfo(
                        icon: Icons.cloud,
                        label: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      Additionalinfo(
                        icon: Icons.air,
                        label: 'wind speed',
                        value: currentWindspeed.toString(),
                      ),
                      Additionalinfo(
                          icon: Icons.beach_access_sharp,
                          label: 'Pressure',
                          value: currentPressure.toString())
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
