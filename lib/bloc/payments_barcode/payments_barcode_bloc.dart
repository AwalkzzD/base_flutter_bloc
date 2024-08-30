import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/payments_barcode/payments_barcode_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/payments_barcode/payments_barcode_provider.dart';

import '../../remote/repository/payments_barcode/request/utils/payments_barcode_request_params.dart';
import '../../remote/repository/payments_barcode/response/payments_barcode_response.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';

class PaymentsBarcodeBloc extends BaseBloc {
  PaginationData subjectPageData = getPaginationHeader(null);

  List<PaymentsBarcodeResponse> barcodeList = List.empty(growable: true);

  PaymentsBarcodeBloc() {
    on<PaymentsBarcodeBlocEvent>((event, emit) async {
      switch (event) {
        /// SetInitialPaymentResponseEvent
        case SetInitialPaymentResponseEvent setInitialPaymentResponseEvent:
          emit(const LoadingState());
          emit(DataState(PaymentsBarcodeResponse()));

        /// SetBarcodeDataByIdEvent
        case SetBarcodeDataByIdEvent setBarcodeDataByIdEvent:
          emit(const LoadingState());
          emit(DataState(barcodeList.firstWhere((element) =>
              element.studentId == setBarcodeDataByIdEvent.selectedStudentId)));

        /// LoadPaymentDataEvent
        case LoadPaymentDataEvent loadPaymentDataEvent:
          emit(const LoadingState());
          if (!loadPaymentDataEvent.isPullToRefresh) {
            emit(const LoadingState());
          }
          if (loadPaymentDataEvent.initialLoad) {
            subjectPageData = getPaginationHeader(null);
            barcodeList.addAll([]);
            emit(const DataState<List<PaymentsBarcodeResponse>>([]));
          }

          await PaymentsBarcodeProvider.paymentsBarcodeRepository
              .apiGetPaymentsBarcodeData(
            loadPaymentDataEvent.idList.join(','),
            PaymentsBarcodeParameters(
                    pageNumber: loadPaymentDataEvent.isPullToRefresh
                        ? 1
                        : subjectPageData.currentPage + 1)
                .toMap(),
            (response, paginationData) {
              emit(const LoadingState());
              if (!loadPaymentDataEvent.isPullToRefresh) {
                emit(const DataState([]));
              }
              subjectPageData = paginationData;
              barcodeList.addAll(response.data);
              emit(DataState<List<PaymentsBarcodeResponse>>(response.data));
              if (loadPaymentDataEvent.selectedStudentId == 0) {
                emit(DataState(response.data.first));
                // selectedUserBarcode.value = barcodeList.value?.first;
              } else {
                emit(const LoadingState());
                add(SetBarcodeDataByIdEvent(
                    selectedStudentId: loadPaymentDataEvent.selectedStudentId));
                /*setBarcodeDatById(loadPaymentDataEvent.selectedStudentId);*/
              }
              if (response.data.isNotEmpty) {
                if (!subjectPageData.isLastPage()) {
                  emit(const LoadingState());
                  add(LoadPaymentDataEvent(
                    initialLoad: false,
                    idList: loadPaymentDataEvent.idList,
                    selectedStudentId: loadPaymentDataEvent.selectedStudentId,
                    isPagination: loadPaymentDataEvent.isPagination,
                    isPullToRefresh: loadPaymentDataEvent.isPullToRefresh,
                  ));
                } else {
                  emit(DataState(response.data));
                }
              } else {
                emit(EmptyDataState(
                    string("common_labels.label_no_data_found")));
              }
            },
            (error) {
              emit(ErrorRetryState(error.errorMsg, () {
                emit(const LoadingState());
                add(LoadPaymentDataEvent(
                  initialLoad: loadPaymentDataEvent.initialLoad,
                  idList: loadPaymentDataEvent.idList,
                  selectedStudentId: loadPaymentDataEvent.selectedStudentId,
                  isPagination: loadPaymentDataEvent.isPagination,
                  isPullToRefresh: loadPaymentDataEvent.isPullToRefresh,
                ));
              }));
            },
          );
      }
    });
  }
}
