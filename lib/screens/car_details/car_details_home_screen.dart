import 'package:base_flutter_bloc/screens/car_details/car_manufacturers_details.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: CarManufacturersList()),
              const Divider(thickness: 2),
              const Expanded(child: CarMakesList()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CarManufacturersDetails();
                    }));
                  },
                  child: const Text('Manufacturers Details'))
            ],
          ),
        ),
      ),
    );
  }
}
