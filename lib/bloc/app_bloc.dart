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

import '../remote/repository/consents/response/consents_student_response.dart';
import '../utils/dropdown/dropdown_option_model.dart';

class AppBloc extends BaseBloc<BaseEvent, BaseState> {
  late BehaviorSubject<List<TerminologyListResponse>> terminologies;
  late BehaviorSubject<StudentForRelativeExtended?> student;
  late BehaviorSubject<List<StudentForRelativeExtended>> studentList;
  late BehaviorSubject<AcademicPeriodResponse?> academicPeriod;
  late BehaviorSubject<List<AcademicPeriodResponse>> academicPeriodList;
  late BehaviorSubject<UserResponse?> user;
  late BehaviorSubject<InstituteResponse?> institute;
  late BehaviorSubject<MobileLicenseMenuResponse?> mobileMenu;
  late BehaviorSubject<DropDownOptionModel> calenderType;

  get calenderTypeStream => calenderType.stream;

  late BehaviorSubject<bool> showStudentQrCode;

  /// this list contains userId,consent list
  /// Student - single record
  /// Parent - multiple records
  /// Teacher - Single records
  late BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>
      mainConsentsList;

  late BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>
      requiredUnAnsweredConsentsList;

  late BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>
      notRequiredUnAnsweredConsentsList;

  get unAnsweredNotRequiredConsentsListStream =>
      notRequiredUnAnsweredConsentsList.stream;
  bool disallowClosingMandatoryConsentsDialog = false;

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

    mainConsentsList =
        BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>.seeded({});
    requiredUnAnsweredConsentsList =
        BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>.seeded({});
    notRequiredUnAnsweredConsentsList =
        BehaviorSubject<Map<int, List<ConsentsStudentsResponse>>>.seeded({});
  }

  void setShowStudentQrCode(bool flag) {
    if (!showStudentQrCode.isClosed) {
      showStudentQrCode.add(flag);
    }
  }

  void addConsents(int key, List<ConsentsStudentsResponse> consents) {
    consents = groupingConsentForFile(consents);
    mainConsentsList.value.addAll({key: consents});
  }

  void addRequiredUnAnsweredConsents(
      int key, List<ConsentsStudentsResponse> consents) {
    consents = groupingConsentForFile(consents);
    requiredUnAnsweredConsentsList.value.addAll({key: consents});
  }

  void addNotRequiredUnAnsweredConsents(
      int key, List<ConsentsStudentsResponse> consents) {
    consents = groupingConsentForFile(consents);
    notRequiredUnAnsweredConsentsList.value.addAll({key: consents});
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

  /// grouping file consent
  List<ConsentsStudentsResponse> groupingConsentForFile(
      List<ConsentsStudentsResponse> dataList) {
    List<FileAnswerArray> listTobeAdded = [];

    /// Collect all File1 answers.
    for (var element in dataList) {
      if (element.entries != null) {
        for (var entryElement in element.entries!) {
          if (entryElement.type == 'File1') {
            listTobeAdded.add(FileAnswerArray(
              answer: entryElement.answer,
              answerLabel: entryElement.answerLabel,
            ));
          }
        }
      }
    }

    /// Assign collected File1 answers to the first File1 entry and remove extra entries.
    for (var element in dataList) {
      if (element.entries != null) {
        bool firstFile1Found = false;
        element.entries!.removeWhere((entryElement) {
          if (entryElement.type == 'File1') {
            if (!firstFile1Found) {
              entryElement.fileAnswerList = listTobeAdded;
              firstFile1Found = true;
              return false; // Do not remove the first File1 entry.
            } else {
              return true; // Remove subsequent File1 entries.
            }
          }
          return false; // Do not remove non-File1 entries.
        });
      }
    }

    // Print the results for debugging.
    for (var element in dataList) {
      if (element.entries != null) {
        for (var entryElement in element.entries!) {
          if (entryElement.type == 'File1') {}
        }
      }
    }
    return dataList;
  }
}
