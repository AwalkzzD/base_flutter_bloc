import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/user/response/academic_periods_response.dart';
import '../../utils/common_utils/shared_pref.dart';

class LearningBloc extends BaseBloc {
  /*LearningBloc() {
    on<LearningBlocEvent>((event, emit) {
      switch (event) {
        // case Event:
        //   emit(const LoadingState());
      }
    });
  }*/

  late BehaviorSubject<int> currentIndex;

  get currentIndexStream => currentIndex.stream;

  late BehaviorSubject<AcademicPeriodResponse?> currentPeriod;

  get currentPeriodStream => currentPeriod.stream;

  LearningBloc() {
    currentIndex = BehaviorSubject<int>.seeded(0);
    currentPeriod =
        BehaviorSubject<AcademicPeriodResponse?>.seeded(getAcademicPeriod());
  }
}
