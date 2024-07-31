import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc<BaseEvent, BaseState> {
  late BehaviorSubject<List<TerminologyListResponse>> terminologies;
  late BehaviorSubject<StudentForRelativeExtended?> student;
  late BehaviorSubject<List<StudentForRelativeExtended>> studentList;
  late BehaviorSubject<AcademicPeriodResponse?> academicPeriod;
  late BehaviorSubject<List<AcademicPeriodResponse>> academicPeriodList;
  late BehaviorSubject<UserResponse?> user;
  late BehaviorSubject<InstituteResponse?> institute;
  late BehaviorSubject<MobileLicenseMenuResponse?> mobileMenu;

  late BehaviorSubject<bool> showStudentQrCode;

  AppBloc() {
    terminologies = BehaviorSubject.seeded(getTerminologiesList());
    student = BehaviorSubject.seeded(getStudent());
    studentList = BehaviorSubject.seeded(getStudentList());
    user = BehaviorSubject.seeded(getUser());
    academicPeriod = BehaviorSubject.seeded(getAcademicPeriod());
    academicPeriodList = BehaviorSubject.seeded(getAcademicPeriodList());
    institute = BehaviorSubject.seeded(getInstitute());
    mobileMenu = BehaviorSubject.seeded(getMobileMenu());
    showStudentQrCode = BehaviorSubject.seeded(false);
  }

  void refreshData() {
    if (!terminologies.isClosed) {
      terminologies.add(getTerminologiesList());
    }
    if (!student.isClosed) {
      student.add(getStudent());
    }
    if (!studentList.isClosed) {
      studentList.add(getStudentList());
    }
    if (!user.isClosed) {
      user.add(getUser());
    }
    if (!institute.isClosed) {
      institute.add(getInstitute());
    }
    if (!academicPeriod.isClosed) {
      academicPeriod.add(getAcademicPeriod());
    }
    if (!academicPeriodList.isClosed) {
      academicPeriodList.add(getAcademicPeriodList());
    }
    if (!mobileMenu.isClosed) {
      mobileMenu.add(getMobileMenu());
    }
    if (!showStudentQrCode.isClosed) {
      showStudentQrCode.add(false);
    }
  }
}
