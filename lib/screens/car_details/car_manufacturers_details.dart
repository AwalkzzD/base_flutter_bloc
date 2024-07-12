import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc_event.dart';
import 'package:base_flutter_bloc/remote/models/car/manufacturers/car_manufacturers_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarManufacturersDetails extends BasePage {
  const CarManufacturersDetails({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _CarManufacturersDetailsState();
}

class _CarManufacturersDetailsState
    extends BasePageState<CarManufacturersDetails, CarManufacturersBloc> {
  final CarManufacturersBloc _bloc = CarManufacturersBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return BlocProvider<CarManufacturersBloc>.value(
      value: BlocProvider.of<CarManufacturersBloc>(context),
      child: Column(children: [
        Expanded(child: buildCarManufacturersList()),
        ElevatedButton(
            // onPressed: () => getBloc().add(GetCarManufacturersEvent()),
            onPressed: () => (!getBloc().isClosed)
                ? getBloc().add(GetCarManufacturersEvent())
                : print('Details Page -> Bloc instance is closed'),
            child: const Text('Get Car Manufacturers')),
      ]),
    );
    /*return Column(children: [
      Expanded(child: buildCarManufacturersList()),
      ElevatedButton(
          // onPressed: () => getBloc().add(GetCarManufacturersEvent()),
          onPressed: () => (!getBloc().isClosed)
              ? getBloc().add(GetCarManufacturersEvent())
              : print('Details Page -> Bloc instance is closed'),
          child: const Text('Get Car Manufacturers')),
    ]);*/
  }

  @override
  CarManufacturersBloc getBloc() =>
      BlocProvider.of<CarManufacturersBloc>(context);

  /*@override
  void dispose() {
    getBloc().close();
    super.dispose();
  }*/

  /// --------------------------------------  WIDGETS  --------------------------------------

  Widget buildCarManufacturersList() {
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
                          '${((state.data) as List<Result>)[index].mfrName}'),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemCount: ((state.data) as List<Result>).length);
      },
    );
  }
}
