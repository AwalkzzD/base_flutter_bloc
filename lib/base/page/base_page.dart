import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/bloc/theme/theme_bloc.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
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

  Widget? get customAppBar => null;

  Widget? get customBottomNavigationBar => null;

  Widget? get customDrawer => null;

  Color? get customScaffoldColor => null;

  bool get canPop => false;

  bool get customBackPressed => false;

  bool get enableBackPressed => true;

  NavigatorState get router => Navigator.of(context);

  NavigatorState get globalRouter => Navigator.of(globalContext);

  @override
  void initState() {
    super.initState();
    getBloc;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
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

  bool isDrawerOpen() {
    return _scaffoldKey.currentState?.isDrawerOpen ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (BuildContext context) => getBloc,
      child: enableBackPressed
          ? PopScope(
              canPop: canPop,
              onPopInvoked: (didPop) => onBackPressed(didPop, context),
              child: getCustomScaffold())
          : getCustomScaffold(),
    );
  }

  void openDrawer() => _scaffoldKey.currentState?.openDrawer();

  void closeDrawer() => _scaffoldKey.currentState?.closeDrawer();

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
    Function(BaseState previousState, BaseState currentState)? performWhen,
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
            case InitialState initialState:
              return (onInitialReturn == null)
                  ? Container(color: primaryColor)
                  : onInitialReturn(initialState);
            case LoadingState loadingState:
              return (onLoadingReturn == null)
                  ? const Center(child: CircularProgressIndicator())
                  : onLoadingReturn(loadingState);
            case DataState dataState:
              return onDataReturn(dataState);
            case ErrorState errorState:
              return (onErrorReturn == null)
                  ? Center(
                      child: SizedBox(
                        child: Text(
                            errorState.errorMessage ?? 'Something went wrong!'),
                      ),
                    )
                  : onErrorReturn(errorState);

            case EmptyDataState emptyDataState:
            default:
              return const SizedBox(
                child: Center(child: Text('Unexpected Data State')),
              );
          }
        },
        listenWhen: (previousState, currentState) {
          return (performWhen != null)
              ? performWhen(previousState, currentState)
              : true;
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

  showCustomLoader() {
    context.loaderOverlay.show(widgetBuilder: (_) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: CircularProgressIndicator(
              color:
                  Theme.of(context).progressIndicatorTheme.circularTrackColor),
        ),
      );
    });
  }

  showLoader() {
    context.loaderOverlay.show();
  }

  hideLoader() {
    context.loaderOverlay.hide();
  }

  @override
  void dispose() {
    getBloc.close();
    super.dispose();
  }

  void onBackPressed(bool didPop, BuildContext context) {
    if (!customBackPressed) {
      if (!didPop) {
        router.pop();
      }
    }
  }
}
