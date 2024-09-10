import 'package:base_flutter_bloc/base/component/base_bloc.dart';

class CommonFilterScreenBloc extends BaseBloc {
  late DateTime fromDate;
  late DateTime toDate;
  String fromDateFormatted = '';
  String toDateFormatted = '';
}
