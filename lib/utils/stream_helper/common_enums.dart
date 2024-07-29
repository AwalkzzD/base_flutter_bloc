import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';

enum NotificationDeviceType { APNS, FCM }

enum MobilePlatform { Android, Ios }

enum WalletCardType { Benefits }

enum ConsentViewType {
  All,
  Required,
  NotRequired, //Single
}

enum TerminologyType {
  Grade,
  Stream,
  Location,
  Student,
  Teacher,
  Subject,
  Group
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
  AssignmentAnswers
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
