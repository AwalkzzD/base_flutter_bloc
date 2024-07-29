import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<B extends BaseBloc> extends State<BasePage>
    with WidgetsBindingObserver {
  final bool _isPaused = false;

  B getBloc();

  @override
  void initState() {
    super.initState();
    getBloc();
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (BuildContext context) => getBloc(),
      child: getCustomScaffold(),
    );
  }

  Widget getCustomScaffold() {
    return getScaffold();
  }

  Scaffold getScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: BlocProvider<B>(
          create: (BuildContext context) => getBloc(),
          child: buildWidget(context)),
    );
  }

  Widget buildWidget(BuildContext context);

  getBlocConsumer({
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
        bloc: getBloc(),
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
                  ? print('Initial State')
                  : onInitialReturn(state);
            case LoadingState():
              (onLoadingPerform == null)
                  ? print('Loading Data')
                  : onLoadingPerform(state);
            case DataState():
              onDataPerform(state);
            case ErrorState():
              (onErrorPerform == null)
                  ? print('Error fetching Data')
                  : onErrorPerform(state);
            default:
              print('Invalid State');
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
        color: Colors.white,
        child:
            const Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    });
  }

  @override
  void dispose() {
    getBloc().close();
    super.dispose();
  }
}
