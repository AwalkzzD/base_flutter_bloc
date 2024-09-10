import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final Function()? onRetry;
  final String? emptyDataMessage;

  const BaseState({
    this.data,
    this.errorMessage,
    this.onRetry,
    this.emptyDataMessage,
  });

  @override
  List<Object?> get props => [];
}

class InitialState extends BaseState {
  const InitialState() : super(data: null, errorMessage: null);
}

class LoadingState extends BaseState {
  const LoadingState() : super(data: null, errorMessage: null);
}

class OverlayLoadingState extends BaseState {
  final bool showCustomOverlay;

  const OverlayLoadingState({this.showCustomOverlay = false})
      : super(data: null, errorMessage: null);
}

class DataState<T> extends BaseState {
  const DataState(T response) : super(data: response, errorMessage: null);
}

class ErrorState extends BaseState {
  const ErrorState(String errorMsg) : super(data: null, errorMessage: errorMsg);
}

class ErrorRetryState extends BaseState {
  const ErrorRetryState(String errorMsg, Function()? onRetry)
      : super(errorMessage: errorMsg, onRetry: onRetry);
}

class EmptyDataState extends BaseState {
  const EmptyDataState(String emptyDataMessage)
      : super(emptyDataMessage: emptyDataMessage);
}
