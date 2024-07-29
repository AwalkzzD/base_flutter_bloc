class ApiEndpoints {
  // internal constructor
  ApiEndpoints._();

  static const String identityServerUri = "https://identity.classter.com/";
  static const String clientId = "63774826-4c6c-4535-a7a0-bc5e2526c0b4";
  static const String clientSecret = "a8f6d768-20bd-4c1d-91ec-6aa06760eb5d";
  static const String responseType = "code id_token";
  static const String scope =
      "openid profile roles consumer_api offline_access mobile";

  static const String authorizeEndPoint =
      "${identityServerUri}ids/connect/authorize";
  static const String tokenEndpoint = "${identityServerUri}ids/connect/token";
  static const String sessionEndpoint =
      "${identityServerUri}ids/connect/endsession";

  static const String logInCallBack =
      "m-app://15814b16-c2ae-44b2-a644-8291bb5b0996/";
  static const String logOutCallBack =
      "m-app://c3a41f45-ef86-44c9-83a7-c7132f443dc4/";

  static const String api = "/api";

  static const String mobiles = "mobiles";
  static const String teachers = "teachers";
  static const String students = "students";
  static const String groups = "groups";
  static const String sessions = "sessions";
  static const String collection = "collection";
  static const String timetablePeriod = "timetableperiods";
  static const String timetableCategories = "timetablecategories";
  static const String timetableSessions = "timetableSessions";
  static const String services = "services";
  static const String skipServicesDateCheck = "skipServicesDateCheck";
  static const String wallet = "wallet";
  static const String availability = "availability";
  static const String assignments = "assignments";

  /// user
  static const String settings = "/api/settings";
  static const String identities = "/api/identities";

  static const String checkLicense = "$api/$mobiles/CheckLicense";
  static const String mobileLicense = "$api/$mobiles/License";
  static const String mobileLicenseMenus = "$api/$mobiles/License/Info";
  static const String mobileNotificationRegister = "$api/$mobiles/register";
  static const String mobileNotificationUnRegister = "$api/$mobiles/unregister";

  static const String user = "/api/users/";
  static const String educationPrograms = "/api/educationalprograms/students";
  static const String studentsRelative = "/api/relatives";
  static const String academicPeriods = "/api/academicperiods";
  static const String institute = "/api/institutes";
  static const String cards = "/api/cards";
  static const String cardsByType = "$cards/types";

  /// profile
  static const String userProfile = "profile";
  static const String userProfilePreferences = "profile/preferences";
  static const String userProfilePref = "/api/users/profile/preferences";
  static const String userProfileContact = "profile/contact";

  /// terminologies
  static const String terminologies = "/api/terminologies";

  /// calender
  static const String calender = "/api/events/calendar";

  /// sessions
  static const String sessionTasks = "/api/sessions/tasks";

  /// holidays
  static const String holidays = "/api/holidays";

  /// events
  static const String events = "/api/events/";
  static const String joinEvent = "join";
  static const String eventType = "eventType";

  /// learning
  static const String learning = "/api/learnings/";
  static const String learningStudents = "$learning/students/";
  static const String learningSubjects = "$learning/subjects/";

  /// services
  static const String apiServices = "$api/$services";
  static const String servicesTeachers = "$api/$services/teachers/";

  /// subject
  static const String subjects = "/api/subjects";
  static const String subjectsStudent = "$subjects/students";
  static const String subjectsTeacher = "$subjects/teachers";

  /// homework
  static const String homework = "/api/homeworks";
  static const String homeworkStudent = "$homework/students";
  static const String homeworkAnswer = "$homework/answers";
  static const String homeworkGroup = "$homework/groups";
  static const String homeworkSubject = "subjects";
  static const String homeworkMessage = "message";

  /// teacher groups
  static const String teacherGroups = "/api/groups/teachers";

  /// teacher sessions
  static const String session = "/api/sessions";
  static const String teacherSessions = "/api/sessions/teachers";

  /// teacher attendance
  static const String teacherAttendance = "/api/attendances/teachers";
  static const String teacherAttendanceGroup = "/groups";
  static const String teacherAttendanceSessions = "/sessions";
  static const String teacherAttendanceCollections =
      "api/attendances/collection";
  static const String teacherAttendanceVerifyCollections =
      "api/attendances/verify/True/collection";
  static const String teacherAttendanceTypeDaily = "/daily";

  /// timetable
  static const String timetableCategory = "/api/timetablecategories";
  static const String timetableCategoryStudents =
      "/api/timetablecategories/students";
  static const String timetables = "/api/timetables/timetablecategories";
  static const String timetableCategoryTeacher =
      "/api/timetablecategories/teachers";
  static const String timetablePeriods = "$api/timetableperiods";
  static const String timetablePeriodsGroup = "groups";
  static const String timetablePeriodsSubject = "subjects";
  static const String timetablePeriodsTimetableCategories =
      "timetableCategories";

  /// lessons
  static const String lessons = "/api/lessonplannings";
  static const String lessonsSubject = "subjects";

  /// files and Links
  static const String files = "/api/files";
  static const String links = "links";

  /// messages
  static const String messages = "/api/messages";
  static const String messageCategories = "/api/messagecategories";
  static const String messageConversation = "conversation";
  static const String messageRead = "read";
  static const String messageRights = "/api/messagerights/users";
  static const String messageFolderUsers = "/api/messagefolders/users";
  static const String messageFolder = "/api/messagefolders";
  static const String messageTransferFolder = "/api/messagefolders/transfer";

  /// announcement
  static const String announcement = "/api/events/announcements";
  static const String announcementEventType = "eventtype";
  static const String announcementRead = "read";

  /// announcement central
  static const String announcementCentral = "/api/events/announcements/central";

  /// attendance
  static const String attendanceStudent = "/api/attendances/students/";
  static const String attendanceStudentStatistics = "statistics";
  static const String attendanceSubmission = "/api/attendanceIntentions";
  static const String attendanceSubmissionTimeTable =
      "/api/attendanceIntentions/timetableperiods";
  static const String attendanceSubmissionCategories =
      "/api/attendanceIntentions/timetablecategories";

  /// assessment and assignment
  static const String assessmentList = "/api/assessments/students";
  static const String assessmentTypeList = "/api/assessmenttypes/students";
  static const String markingPeriods = "/api/markingperiods";
  static const String upComingAssessment = "upcoming";
  static const String markedAssessment = "marked";
  static const String apiAnalytics = "/api/analytics/students";
  static const String apiAnalyticsAssessment = "assessments";
  static const String apiAnalyticsSubject = "subject";
  static const String assessmentGroupedPerMarkingPeriod =
      "assessmentgroupedpermarkingperiod";

  /// assignment
  static const String apiAssignments = "$api/$assignments";
  static const String studentAssignments = "$apiAssignments/$students";

  /// consent
  static const String consents = "api/admissionsdata/";
  static const String consentsCollection = "collection";
  static const String consentStudents = "students";
  static const String getPin = "/api/security/pin";

  static const String licenseAndTerms = "http://mobileterms.classter.com/";

  /// payments barcode
  static const String paymentsBarcode = "/api/barcodes/students/(";
  static const String payments = ")/payments";

  // car details
  static String getCarManufacturers = '/getallmanufacturers';
  static String getCarMakes = '/getallmakes';
}
