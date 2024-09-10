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
    TerminologyType.Student, false, string("default_label.label_student"));

String teacherLiteral() => getLiteral(
    TerminologyType.Teacher, false, string("default_label.label_teacher"));

String teachersLiteral() => getLiteral(
    TerminologyType.Teacher, true, string("default_label.label_teachers"));

String groupLiteral() => getLiteral(
    TerminologyType.Group, false, string("default_label.label_group"));

String subjectLiteral() => getLiteral(
    TerminologyType.Subject, false, string("default_label.label_subject"));

String subjectsLiteral() => getLiteral(
    TerminologyType.Subject, true, string("default_label.label_subjects"));

String gradeLiteral() => getLiteral(
    TerminologyType.Grade, false, string("default_label.label_grade"));

String programLiteral() => getLiteral(
    TerminologyType.Stream, false, string("default_label.label_stream"));

String locationLiteral() => getLiteral(
    TerminologyType.Location, false, string("default_label.label_location"));

String consentsLiteral() => getLiteral(
    TerminologyType.Consents, false, string("default_label.label_consents"));

String tardyLiteral() => getLiteral(
    TerminologyType.Tardy, false, string("default_label.label_tardy"));

String authorizedAbsenceLiteral() => getLiteral(
    TerminologyType.AuthorizedAbsence,
    false,
    string("default_label.label_authorized_absence"));

String unAuthorizedAbsenceLiteral() => getLiteral(
    TerminologyType.UnauthorizedAbsence,
    false,
    string("default_label.label_unauthorized_absence"));

String contactDetailsLiteral() => getLiteral(TerminologyType.ContactData, false,
    string("default_label.label_contact_data"));

String financialDetailsLiteral() => getLiteral(TerminologyType.FinancialData,
    false, string("default_label.label_financial_data"));
