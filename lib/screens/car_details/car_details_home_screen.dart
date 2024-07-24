import 'package:base_flutter_bloc/screens/car_details/widgets/car_makes_list.dart';
import 'package:base_flutter_bloc/screens/car_details/widgets/car_manufacturers_list.dart';
import 'package:flutter/material.dart';

class CarDetailsHomeScreen extends StatefulWidget {
  const CarDetailsHomeScreen({super.key});

  @override
  State<CarDetailsHomeScreen> createState() => _CarDetailsHomeScreenState();
}

class _CarDetailsHomeScreenState extends State<CarDetailsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: CarManufacturersList()),
              Divider(thickness: 2),
              Expanded(child: CarMakesList()),
            ],
          ),
        ),
      ),
    );
  }
}
