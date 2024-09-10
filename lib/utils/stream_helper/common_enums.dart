import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';

import '../common_utils/common_utils.dart';
import '../widgets/terminologies_utils.dart';

enum ScreenType { drawer, login, normal, splash, language }

enum NotificationDeviceType { APNS, FCM }

enum MobilePlatform { Android, Ios }

enum WalletCardType { Benefits }

enum CardMobileDataPageProperties {
  Name, // 0
  Photo, // 1
  InstituteName, // 2
  EducationalPrograms, // 3
  MobilePhone, // 4
  HomePhone, // 5
  Email, // 6
  CustomColor, // 7
  InstituteLogo, // 8
  CustomText, // 9
  CardCode, // 10
  CardBenefitsCode, // 11
  ExpirationDate, // 12
  GlobalRegistrationNumber, // 13
  Card, // 14
  NameLabel, // 15
  UserCode, // 16
  PinCode // 17
}

enum ConsentViewType {
  All,
  Required,
  NotRequired, //Single
}

enum TerminologyType {
  Grade,
  Stream,
  Location,
  AuthorizedAbsence,
  UnauthorizedAbsence,
  Scholarship,
  Student,
  ContactData,
  FinancialData,
  SubjectCredits,
  Tardy,
  GradeType,
  GradeLevel,
  ExaminationLevel,
  Teacher,
  Subject,
  Group,
  MainPersonalData,
  AdmissionData,
  Consents,
  Internship,
  PersonalDataMenu,
  AdmissionApplicationAccept,
  AdmissionApplicationReject,
  EducationalProgramAdmission,
  AttendanceAndProgress,
  Building,
  GradeGeneralInfo,
  MarkingScheme,
  ProgramLearningOutcomes,
  ProfessionalStatus,
}

enum RepresentValueFor { Group, Student, District }

enum AdmissionDataType {
  Checkbox1,
  Comment1,
  Dropdown1,
  Dropdown2,
  Datetime1,
  Datetime2,
  File1,
  Text1,
  Text2,
  Text3,
  Text4,
  Signature,
}

enum EventType {
  Announcement,
  Appointment,
  Event,
  Assessment,
  Crm,
  Session,
  Assignment,
  Holiday,
  Interview
}

enum CardEntityType { None, Student, Teacher, Employee, Relative }

enum ConsentEntityType {
  students,
  teachers,
}

enum AssessmentMarksTrend { None, Up, Down, Same }

enum UploadEntityType {
  Message,
  Assessments,
  Homework,
  AdmissionData,
  Events,
  HomeworkAnswers,
  AssignmentAnswers,
  AssessmentAnswers
}

enum AttendanceStatus {
  Presence,
  Absence,
  Late,
}

enum AttendanceType {
  None,
  Daily,
  TimeTablePeriod,
  Subject,
  Activities,
  Session,
  TimeTable
}

enum AttendanceGeneralCategory { Justified, Unjustified }

enum MessageCategoryType {
  Message,
  Notification,
}

enum MessageType {
  InternalMessage,
  Email,
  Sms,
}

enum MessageDirectory {
  Inbox,
  Sent,
  Archived,
}

enum AttendanceStudentParentPeriodSelection {
  DoNotAllow,
  UsingTimetablePeriods,
  UsingTimeRange
}

enum HomeworkReadStatus { Done, DoneWithIssues, NoResponse, NotDone }

enum AssignmentSubmissionStatus {
  Sent,
  InProgress,
  ReOpened,
  Submitted,
  Reviewed,
  Completed
}

List<String> attendanceStringList = AttendanceStatus.values.map((status) {
  return EnumToString.convertToString(status);
}).toList();

List<String> attendanceGeneralCategoryList =
    AttendanceGeneralCategory.values.map((category) {
  return EnumToString.convertToString(category);
}).toList();

List<String> enumToList<T>(List<T> enumValues) {
  return enumValues.map((value) {
    return EnumToString.convertToString(value);
  }).toList();
}

String attendanceStatusString(String status) {
  String convertedStatus = "";
  if (status == EnumToString.convertToString(AttendanceStatus.Absence)) {
    convertedStatus = string("attendance.absence_type_absence");
  } else if (status ==
      EnumToString.convertToString(AttendanceStatus.Presence)) {
    convertedStatus = string("attendance.absence_type_presence");
  } else if (status == EnumToString.convertToString(AttendanceStatus.Late)) {
    convertedStatus = tardyLiteral();
  } else {
    convertedStatus = status;
  }
  return convertedStatus;
}
