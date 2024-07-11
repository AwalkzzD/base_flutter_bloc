import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc_event.dart';
import 'package:base_flutter_bloc/remote/models/car/makes/car_makes_response.dart';
import 'package:flutter/material.dart';

class CarMakesList extends BasePage {
  const CarMakesList({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _CarMakesListState();
}

class _CarMakesListState extends BasePageState<CarMakesList, CarMakesBloc> {
  final CarMakesBloc _bloc = CarMakesBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Column(children: [
      Expanded(child: buildCarMakesList()),
      ElevatedButton(
          onPressed: () => getBloc().add(GetCarMakesEvent()),
          child: const Text('Get Car Makes')),
    ]);
  }

  @override
  CarMakesBloc getBloc() => _bloc;

  /// --------------------------------------  WIDGETS  --------------------------------------

  Widget buildCarMakesList() {
    return getBlocBuilder(
      onDataState: (state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '${((state.data) as List<Result>)[index].makeName}'),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
            itemCount: ((state.data) as List<Result>).length);
      },
    );
  }
}
