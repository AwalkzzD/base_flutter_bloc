import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage, B extends BaseBloc>
    extends State<T> {
  B getBloc();

  @override
  void initState() {
    super.initState();
    getBloc();
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
      body: buildWidget(context),
    );
  }

  Widget buildWidget(BuildContext context);

  getBlocBuilder({
    Function(BaseState state)? onLoadingState,
    required Function(BaseState state) onDataState,
    Function(BaseState state)? onErrorState,
  }) {
    return BlocBuilder<B, BaseState>(
      builder: (BuildContext context, state) {
        switch (state) {
          case LoadingState():
            return (onLoadingState == null)
                ? const Center(child: CircularProgressIndicator())
                : onLoadingState(state);
          case DataState():
            return onDataState(state);
          case ErrorState():
            return (onErrorState == null)
                ? Center(
                    child: SizedBox(
                      child:
                          Text(state.errorMessage ?? 'Something went wrong!'),
                    ),
                  )
                : onErrorState(state);
          default:
            return const SizedBox(
              child: Center(child: Text('Unexpected Data State')),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
