import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/networking.dart';

// ignore: camel_case_types
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => LocationScreenState();
}

// ignore: camel_case_types
class LocationScreenState extends State<LocationScreen> {
  NetworkHelper networkHelper = NetworkHelper();
  String location = 'karachi';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1682685797828-d3b2561deef4?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ),
          ),
          child: FutureBuilder(
              future: networkHelper.getData(location),
              builder: (context, AsyncSnapshot asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  log("");
                  String temperature =
                      ((asyncSnapshot.data.main.temp - 273).toStringAsFixed(1));
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    children: [
                                      TextField(
                                        onChanged: (value) => location = value,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  );
                                });
                          },
                        ),
                        title: const Text(
                          '  Weather App',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      Text(
                        asyncSnapshot.data.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 2),
                      Text(
                        ("$temperature ℃"),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.w100),
                      ),
                      Row(children: [
                        double.parse(temperature) <= 2
                            ? const Icon(
                                Icons.cloudy_snowing,
                                color: Colors.white,
                                size: 29,
                              )
                            : double.parse(temperature) >= 15
                                ? const Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                    size: 29,
                                  )
                                : double.parse(temperature) < 15
                                    ? const Icon(
                                        Icons.wb_cloudy_sharp,
                                        color: Colors.white,
                                        size: 29,
                                      )
                                    : const Icon(
                                        Icons.sunny,
                                        color: Colors.white,
                                        size: 29,
                                      ),
                        SizedBox(width: MediaQuery.sizeOf(context).width / 40),
                        Text(
                          asyncSnapshot.data.weather[0].main,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ]),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 200,
                      ),
                      const Divider(
                        thickness: 2.5,
                        height: 7,
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 80),
                      Row(
                        children: [
                          const SizedBox(
                            width: 28,
                          ),
                          BottomInfo(
                            // color: Colo,
                            title: 'Wind',
                            temp: asyncSnapshot.data.wind.speed.toString(),
                            unit: 'Km/h',
                            color: Colors.orange,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          BottomInfo(
                            temp: asyncSnapshot.data.clouds.all.toString(),
                            // color: Colo,
                            title: "Clouds",
                            unit: '%',
                            color: Colors.red,
                            width: 4,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          BottomInfo(
                            // color: Colo,
                            title: "Humidity",
                            unit: '%',
                            temp: asyncSnapshot.data.main.humidity.toString(),
                            color: Colors.green,
                            width: 18,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          BottomInfo(
                            title: 'Feels Like',
                            temp: ((asyncSnapshot.data.main.feelsLike - 273)
                                .toStringAsFixed(1)),
                            unit: 'C°',
                            color: Colors.blue,
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

class BottomInfo extends StatelessWidget {
  const BottomInfo({
    super.key,
    required this.title,
    required this.temp,
    required this.unit,
    required this.color,
    required this.width,
  });
  final String title;
  final String temp;
  final Color? color;
  final String unit;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          temp,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
        Text(
          unit,
          style: const TextStyle(color: Colors.white),
        ),
        Stack(
          children: [
            Container(
              height: 4,
              width: 38,
              color: Colors.grey,
            ),
            Container(height: 4, width: width, color: color),
          ],
        ),
      ],
    );
  }
}
