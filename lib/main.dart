import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc.dart';
import 'package:base_flutter_bloc/env/environment.dart';
import 'package:base_flutter_bloc/screens/login/login_screen.dart';
import 'package:base_flutter_bloc/utils/common_utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set Environment
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.PROD,
  );
  Environment().initConfig(environment);

  /// Shared Preferences
  await SpUtil.getInstance();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => LoginBloc()),
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
      home: LoginScreen(),
    );
  }
}
