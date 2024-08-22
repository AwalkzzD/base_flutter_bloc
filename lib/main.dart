import 'dart:developer';

import 'package:base_flutter_bloc/base/routes/router/app_router.dart';
import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/bloc/theme/theme_bloc.dart';
import 'package:base_flutter_bloc/bloc/theme/theme_state.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_state.dart';
import 'package:base_flutter_bloc/env/environment.dart';
import 'package:base_flutter_bloc/screens/splash/splash_screen.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/common_utils/sp_util.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/localization/localization_json_asset_loader.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/dialogs/overlay_custom_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'utils/localization/localization_utils.dart';

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
      BlocProvider(
          create: (BuildContext context) => getThemeMode()
              ? ThemeBloc(ThemeState.darkTheme)
              : ThemeBloc(ThemeState.lightTheme)),
      BlocProvider(create: (BuildContext context) => AppTheme()),
      BlocProvider(
          create: (context) =>
              AppBottomBarBloc(const AppBottomBarBlocState(tabIndex: 0))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: getSupportedLocales(),
      path: 'assets/translations',
      startLocale: getLanguageLocale(getLanguage()),
      assetLoader: const LocalizationJsonAssetLoader(),
      fallbackLocale: const Locale('en', 'GB'),
      useFallbackTranslations: true,
      child: BlocConsumer<ThemeBloc, ThemeState>(
        buildWhen: (previousThemeState, currentThemeState) {
          return previousThemeState.themeData != currentThemeState.themeData;
        },
        builder: (context, themeState) {
          log('Building Theme App');
          return GlobalLoaderOverlay(
            overlayColor: Colors.transparent,
            useDefaultLoading: false,
            overlayWidgetBuilder: (progress) {
              return const OverlayCustomLoader();
            },
            child: ScreenUtilInit(
              designSize: const Size(390, 844),
              builder: () => MaterialApp(
                onGenerateRoute: AppRouter.generateRoute,
                onUnknownRoute: AppRouter.errorRoute,
                theme: themeState.themeData,
                debugShowCheckedModeBanner: false,
                navigatorKey: globalNavigatorKey,
                home: const SplashScreen(),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              ),
            ),
          );
        },
        listenWhen: (previousThemeState, currentThemeState) {
          return previousThemeState.themeData != currentThemeState.themeData;
        },
        listener: (context, themeState) {},
      ),
    );
  }
}

/**/
