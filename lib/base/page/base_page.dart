import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/bloc/theme/theme_bloc.dart';
import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage, B extends BaseBloc>
    extends State<T> with WidgetsBindingObserver {
  final bool _isPaused = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  B get getBloc;

  AppBloc get appBloc => context.read<AppBloc>();

  ThemeBloc get themeBloc => context.read<ThemeBloc>();

  PageRouteInfo? get backButtonInterceptorRoute => null;

  Function()? get onCustomBackPress => null;

  StackRouter get router => AutoRouter.of(context);

  Widget? get customAppBar => null;

  Widget? get customBottomNavigationBar => null;

  Widget? get customDrawer => null;

  Color? get customScaffoldColor => null;

  @override
  void initState() {
    super.initState();
    getBloc;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
    if (backButtonInterceptorRoute != null) {
      BackButtonInterceptor.add(customBackInterceptor);
    }
  }

  Future<bool> customBackInterceptor(
      bool stopDefaultButtonEvent, RouteInfo routeInfo) async {
    if (routeInfo.currentRoute(context)?.settings.name ==
        backButtonInterceptorRoute?.routeName) {
      onCustomBackPress?.call();
      return true;
    } else {
      router.back();
      return true;
    }
  }

  void onResume() {}

  void onReady() {}

  void onPause() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
        create: (BuildContext context) => getBloc, child: getCustomScaffold());
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  Widget getCustomScaffold() {
    return getScaffold();
  }

  Scaffold getScaffold() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: customScaffoldColor,
      resizeToAvoidBottomInset: true,
      drawer: customDrawer,
      appBar: customAppBar as PreferredSizeWidget?,
      bottomNavigationBar: customBottomNavigationBar,
      body: BlocProvider<B>(
          create: (BuildContext context) => getBloc,
          child: buildWidget(context)),
    );
  }

  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleCommon();
  }

  Widget buildWidget(BuildContext context);

  customBlocConsumer({
    B? bloc,
    Function(BaseState state)? onInitialReturn,
    Function(BaseState state)? onInitialPerform,
    Function(BaseState state)? onLoadingReturn,
    Function(BaseState state)? onLoadingPerform,
    required Function(BaseState state) onDataReturn,
    Function(BaseState previousState, BaseState currentState)? returnWhen,
    required Function(BaseState state) onDataPerform,
    Function(BaseState state)? onErrorReturn,
    Function(BaseState state)? onErrorPerform,
  }) {
    return BlocConsumer<B, BaseState>(
        bloc: bloc ?? getBloc,
        buildWhen: (previousState, currentState) {
          return (returnWhen != null)
              ? returnWhen(previousState, currentState)
              : true;
        },
        builder: (BuildContext context, state) {
          switch (state) {
            case InitialState():
              return (onInitialReturn == null)
                  ? const Center(child: Text('No Data'))
                  : onInitialReturn(state);
            case LoadingState():
              return (onLoadingReturn == null)
                  ? const Center(child: CircularProgressIndicator())
                  : onLoadingReturn(state);
            case DataState():
              return onDataReturn(state);
            case ErrorState():
              return (onErrorReturn == null)
                  ? Center(
                      child: SizedBox(
                        child:
                            Text(state.errorMessage ?? 'Something went wrong!'),
                      ),
                    )
                  : onErrorReturn(state);
            default:
              return const SizedBox(
                child: Center(child: Text('Unexpected Data State')),
              );
          }
        },
        listener: (BuildContext context, state) {
          switch (state) {
            case InitialState():
              (onInitialReturn == null)
                  ? log('Initial State')
                  : onInitialReturn(state);
            case LoadingState():
              (onLoadingPerform == null)
                  ? log('Loading Data')
                  : onLoadingPerform(state);
            case DataState():
              onDataPerform(state);
            case ErrorState():
              (onErrorPerform == null)
                  ? log('Error fetching Data')
                  : onErrorPerform(state);
            default:
              log('Invalid State');
          }
        });
  }

  genericBlocConsumer<BL extends StateStreamable<ST>, ST>({
    required BL bloc,
    required Function(ST state) builder,
    Function(ST state)? listener,
    Function(ST previousState, ST currentState)? buildWhen,
    Function(ST previousState, ST currentState)? returnWhen,
  }) {
    return BlocConsumer<BL, ST>(
        bloc: bloc,
        buildWhen: (previousState, currentState) {
          return (returnWhen != null)
              ? returnWhen(previousState, currentState)
              : true;
        },
        builder: (BuildContext context, state) {
          return builder(state);
        },
        listener: (BuildContext context, state) {
          if (listener != null) {
            listener(state);
          }
        });
  }

  showLoader() {
    context.loaderOverlay.show();
  }

  hideLoader() {
    context.loaderOverlay.hide();
  }

  showCustomLoader() {
    context.loaderOverlay.show(widgetBuilder: (_) {
      return Container(
        color: white,
        child:
            const Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    });
  }

  @override
  void dispose() {
    getBloc.close();
    BackButtonInterceptor.remove(customBackInterceptor);
    super.dispose();
  }
}
