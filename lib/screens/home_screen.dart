import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_bloc/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_bloc/widget/weather_detail_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getGreeting() {
    final hour = DateTime.now().hour;

    switch (hour) {
      case >= 5 && < 12:
        return 'Good Morning';
      case >= 12 && < 17:
        return 'Good Afternoon';
      case >= 17 && < 20:
        return 'Good Evening';
      default:
        return 'Good Night';
    }
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Center(
          child: Lottie.network(
              'https://lottie.host/30855cf1-cffe-484a-8a65-c49b91a3e23a/jCxbE1mRmz.json'),
        );
      case >= 300 && < 400:
        return Center(
          child: Lottie.network(
              'https://lottie.host/1390db34-e54d-49ca-8e3e-0d998540775e/PgM6D4XLy8.json'),
        );
      case >= 500 && < 600:
        return Center(
          child: Lottie.network(
              'https://lottie.host/1390db34-e54d-49ca-8e3e-0d998540775e/PgM6D4XLy8.json'),
        );
      case >= 600 && < 700:
        return Center(
          child: Lottie.network(
              'https://lottie.host/e8d3f592-8d6a-4964-be75-395c9f5eacc5/DZyXjrolg8.json'),
        );
      case >= 700 && < 800:
        return Center(
          child: Lottie.network(
              'https://lottie.host/026eabca-7b3e-4998-a237-3d118a3dfce5/sgBeLuj7OV.json'),
        );
      case == 800:
        return Center(
          child: Lottie.network(
              'https://lottie.host/f47a5e20-7a48-4df8-bd9d-afc31c510513/uB1HRqSyzN.json'),
        );
      case >= 800 && <= 804:
        return Center(
          child: Lottie.network(
              'https://lottie.host/1f0114e4-6128-4d65-9b09-3e14a467912a/0bljgXmKb6.json'),
        );
      default:
        return Center(
          child: Lottie.network(
              'https://lottie.host/1f0114e4-6128-4d65-9b09-3e14a467912a/0bljgXmKb6.json'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFAB40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍${state.weather.areaName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            getGreeting(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd •')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherDetailTile(
                                title: 'Sunrise',
                                value: DateFormat()
                                    .add_jm()
                                    .format(state.weather.sunrise!),
                                assetPath: 'assets/11.png',
                              ),
                              WeatherDetailTile(
                                title: 'Sunset',
                                value: DateFormat()
                                    .add_jm()
                                    .format(state.weather.sunset!),
                                assetPath: 'assets/12.png',
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherDetailTile(
                                title: 'Temp Max',
                                value:
                                    '${state.weather.tempMax!.celsius!.round()}°C',
                                assetPath: 'assets/13.png',
                              ),
                              WeatherDetailTile(
                                title: 'Temp Min',
                                value:
                                    '${state.weather.tempMin!.celsius!.round()}°C',
                                assetPath: 'assets/14.png',
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
