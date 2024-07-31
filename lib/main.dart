import 'package:base_flutter_bloc/base/routes/app_router.dart';
import 'package:base_flutter_bloc/base/routes/utils/route_observer_logger.dart';
import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc.dart';
import 'package:base_flutter_bloc/env/environment.dart';
import 'package:base_flutter_bloc/utils/common_utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
      BlocProvider(create: (BuildContext context) => AppBloc()),
      BlocProvider(create: (BuildContext context) => CarManufacturersBloc()),
      BlocProvider(create: (BuildContext context) => CarMakesBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter(enableLogging: true);

  RouterConfig<Object>? _routerConfig;

  @override
  void initState() {
    super.initState();
    if (_appRouter.enableLogging) {
      _routerConfig =
          _appRouter.config(navigatorObservers: () => [RouteObserverLogger()]);
    } else {
      _routerConfig = _appRouter.config();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _routerConfig,
      ),
    );
  }
}
