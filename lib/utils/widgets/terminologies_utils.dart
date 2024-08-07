import 'package:collection/collection.dart';

import '../../remote/repository/terminology/response/terminology_list_response.dart';
import '../common_utils/common_utils.dart';
import '../common_utils/shared_pref.dart';
import '../enum_to_string/enum_to_string.dart';
import '../stream_helper/common_enums.dart';

String getLiteral(
    TerminologyType terminologyType, bool plural, String defaultLiteral) {
  List<TerminologyListResponse> allTerminologies = getTerminologiesList();
  TerminologyListResponse? terminologyResponse =
      allTerminologies.firstWhereOrNull((element) =>
          element.terminology == EnumToString.convertToString(terminologyType));
  if (terminologyResponse == null) {
    return defaultLiteral;
  }
  return (plural
          ? terminologyResponse.descriptionPlural
          : terminologyResponse.description) ??
      defaultLiteral;
}

String studentLiteral() => getLiteral(
    TerminologyType.Student, false, string("common_labels.label_student"));

String teacherLiteral() => getLiteral(
    TerminologyType.Teacher, false, string("common_labels.label_teacher"));

String teachersLiteral() => getLiteral(
    TerminologyType.Teacher, true, string("common_labels.label_teachers"));

String groupLiteral() => getLiteral(
    TerminologyType.Group, false, string("common_labels.label_group"));

String subjectLiteral() => getLiteral(
    TerminologyType.Subject, false, string("common_labels.label_subject"));

String subjectsLiteral() => getLiteral(
    TerminologyType.Subject, true, string("common_labels.label_subjects"));

String gradeLiteral() => getLiteral(
    TerminologyType.Grade, false, string("common_labels.label_grade"));

String programLiteral() => getLiteral(
    TerminologyType.Stream, false, string("common_labels.label_stream"));

String locationLiteral() => getLiteral(
    TerminologyType.Location, false, string("common_labels.label_location"));
