import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/base/routes/app_router.gr.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends BasePage {
  const HomeScreen({super.key});

  @override
  BasePageState<BaseBloc<BaseEvent, BaseState>> getState() =>
      _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeBloc> {
  final HomeBloc _bloc = HomeBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Home Screen'),
          TextButton(
              onPressed: () {
                router.push(const TempRoute());
              },
              child: const Text('Push')),
          TextButton(onPressed: () {}, child: const Text('Pop')),
          TextButton(onPressed: () {}, child: const Text('Empty')),
        ],
      ),
    );
  }

  @override
  HomeBloc getBloc() => _bloc;
}
