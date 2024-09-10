import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:collection/collection.dart';

class MenuUtils {
  bool isMenuAvailable(String key) {
    MobileLicenseMenuResponse? menuResponse = getMobileMenu();
    if (menuResponse != null) {
      List<Menu> menus = menuResponse.menus ?? [];
      Menu? menu = menus.firstWhereOrNull((element) => element.view == key);
      if (menu == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool isMenuAvailableById(int id) {
    MobileLicenseMenuResponse? menuResponse = getMobileMenu();
    if (menuResponse != null) {
      List<Menu> menus = menuResponse.menus ?? [];
      Menu? menu = menus.firstWhereOrNull((element) => element.id == id);
      if (menu == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool isMessageMenu() {
    //return false;
    return isMenuAvailable("messagecenterpage");
  }

  bool isAnnouncementsMenu() {
    return isMenuAvailable("announcementpage");
  }

  bool isCalenderMenu() {
    return isMenuAvailable("schedulepage");
  }

  bool isTimeTableMenu() {
    return isMenuAvailable("timetablepage");
  }

  bool isAttendanceMenu() {
    return isMenuAvailable("attendancepage");
  }

  bool isTeacherAttendanceMenu() {
    return isMenuAvailable("teacherattendancefilterpage");
  }

  bool isTeacherServiceAttendanceMenu() {
    return isMenuAvailable("activityattendancepage");
  }

  bool isHomeWorkMenu() {
    return isMenuAvailable("homeworkpage");
  }

  bool isTeacherHomeWorkMenu() {
    return isMenuAvailable("teacherhomeworkfilterpage");
  }

  bool isPaymentBarcodeMenu() {
    return isMenuAvailable("paymentbarcodespage");
  }

  bool isAttendanceIntentionMenu() {
    return isMenuAvailable("attendanceintentionpage");
  }

  bool isRouteExceptionsMenu() {
    return isMenuAvailable("busexceptionpage");
  }

  bool isAssessmentOverviewMenu(bool? isParent) {
    if (isParent == true) {
      return isMenuAvailableById(1012);
    } else {
      return isMenuAvailableById(1011);
    }
  }

  bool isAssessmentMenu(bool? isParent) {
    if (isParent == true) {
      return isMenuAvailableById(1003);
    } else {
      return isMenuAvailableById(1003);
    }
  }

  bool isAssignmentMenu(bool? isParent) {
    if (isParent == true) {
      return isMenuAvailableById(1013);
    } else {
      return isMenuAvailableById(1012);
    }
  }

  bool isLearningSubjectsMenu(bool? isParent) {
    if (isParent == true) {
      return isMenuAvailableById(1011);
    } else {
      return isMenuAvailableById(1010);
    }
  }

  bool isLearningTeachersMenu(bool? isParent) {
    if (isParent == true) {
      return isMenuAvailableById(1010);
    } else {
      return isMenuAvailableById(1009);
    }
  }
}
