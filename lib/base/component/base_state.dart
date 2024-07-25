import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  final T? data;
  final String? errorMessage;

  const BaseState({this.data, this.errorMessage});

  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {
  const InitialState() : super(data: null, errorMessage: null);
}

class LoadingState extends BaseState {
  const LoadingState() : super(data: null, errorMessage: null);
}

class DataState<T> extends BaseState {
  const DataState(T response) : super(data: response, errorMessage: null);
}

class ErrorState extends BaseState {
  const ErrorState(String errorMsg) : super(data: null, errorMessage: errorMsg);
}
