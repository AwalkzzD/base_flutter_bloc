import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc.dart';
import 'package:base_flutter_bloc/screens/car_details/car_details_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => CarManufacturersBloc()),
      BlocProvider(create: (BuildContext context) => CarMakesBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (BuildContext context) => CarManufacturersBloc()),
        BlocProvider(create: (BuildContext context) => CarMakesBloc()),
      ], child: const CarDetailsHomeScreen()),
    );*/
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarDetailsHomeScreen(),
    );
  }
}
