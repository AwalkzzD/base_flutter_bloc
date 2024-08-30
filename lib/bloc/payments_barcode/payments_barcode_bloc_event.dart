import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class PaymentsBarcodeBlocEvent extends BaseEvent {}

class LoadPaymentDataEvent extends PaymentsBarcodeBlocEvent {
  final bool isPagination;
  final bool isPullToRefresh;
  final bool initialLoad;
  final List<int> idList;
  final int selectedStudentId;

  LoadPaymentDataEvent(
      {this.isPagination = false,
      this.isPullToRefresh = false,
      required this.initialLoad,
      required this.idList,
      required this.selectedStudentId});
}

class SetBarcodeDataByIdEvent extends PaymentsBarcodeBlocEvent {
  final int selectedStudentId;

  SetBarcodeDataByIdEvent({required this.selectedStudentId});
}

class SetInitialPaymentResponseEvent extends PaymentsBarcodeBlocEvent {}
