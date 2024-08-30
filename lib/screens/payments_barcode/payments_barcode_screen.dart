import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:base_flutter_bloc/bloc/payments_barcode/payments_barcode_bloc.dart';
import 'package:base_flutter_bloc/bloc/payments_barcode/payments_barcode_bloc_event.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../remote/repository/payments_barcode/response/payments_barcode_response.dart';
import '../../utils/appbar/appbar_profile_view.dart';
import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/auth/user_claim_helper.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/widgets/image_view.dart';

class PaymentsBarcodeScreen extends BasePage {
  const PaymentsBarcodeScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _PaymentsBarcodeScreenState();
}

class _PaymentsBarcodeScreenState
    extends BasePageState<PaymentsBarcodeScreen, PaymentsBarcodeBloc> {
  final PaymentsBarcodeBloc _bloc = PaymentsBarcodeBloc();

  @override
  bool get isRefreshEnable => true;

  @override
  Future<void> onRefresh() {
    getBloc.add(LoadPaymentDataEvent(
      isPagination: false,
      isPullToRefresh: true,
      initialLoad: true,
      idList: getIdList(),
      selectedStudentId:
          context.read<HomeBloc>().selectedStudent.value?.id ?? 0,
    ));
    return super.onRefresh();
  }

  @override
  void onReady() {
    getBloc.add(SetInitialPaymentResponseEvent());
    getBloc.add(LoadPaymentDataEvent(
      isPagination: true,
      isPullToRefresh: false,
      initialLoad: true,
      idList: getIdList(),
      selectedStudentId:
          context.read<HomeBloc>().selectedStudent.value?.id ?? 0,
    ));
    super.onReady();
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
          title: string('payments_barcode.label_payments_barcode'),
          onBackPressed: () => router.pop(),
          trailing: [
            AppBarButtonProfileView(
                student: context.read<HomeBloc>().selectedStudent,
                onStudentClick: (student) {
                  if (student != null) {
                    context.read<HomeBloc>().setStudent(student);
                    if (student.id != null) {
                      getBloc.add(SetBarcodeDataByIdEvent(
                          selectedStudentId: student.id ?? 0));
                      /*getBloc.setBarcodeDatById(student.id!);*/
                    }
                  }
                })
          ]);

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case List<PaymentsBarcodeResponse> paymentBarcodeList:
            if (getBloc.barcodeList.isNotEmpty) {
              return Column(children: [
                buildBarCodeTextWidget(
                    paymentBarcodeList.first.barcodeString ?? ''),
                SizedBox(height: 14.h),
                ImageView(
                    image: paymentBarcodeList.first.barcode ?? '',
                    imageType: ImageType.base64),
              ]);
            } else {
              return const SizedBox();
            }
          case PaymentsBarcodeResponse paymentsBarcodeResponse:
            if (getBloc.barcodeList.isNotEmpty) {
              return Column(children: [
                buildBarCodeTextWidget(
                    paymentsBarcodeResponse.barcodeString ?? ''),
                SizedBox(height: 14.h),
                ImageView(
                    image: paymentsBarcodeResponse.barcode ?? '',
                    imageType: ImageType.base64),
              ]);
            } else {
              return const SizedBox();
            }
        }
      },
      onDataPerform: (state) {},
    );
  }

  Widget buildBarCodeTextWidget(String barCode) {
    return Row(children: [
      Flexible(
        child: Text(
          "${string('payments_barcode.label_payments_code')} $barCode",
          style: styleSmall4Medium.copyWith(color: themeOf().textPrimaryColor),
        ),
      ),
    ]);
  }

  List<int> getIdList() {
    List<int> studentIdList = [];
    UserTypes? userTypes = getRequestProperties()?.userType;
    if (userTypes == UserTypes.Parent) {
      for (var element in appBloc.studentList.value) {
        if (element.id != null) {
          studentIdList.add(element.id!);
        }
      }
    } else {
      studentIdList = [getRequestProperties()!.entityId];
    }
    return studentIdList;
  }

  @override
  PaymentsBarcodeBloc get getBloc => _bloc;
}
