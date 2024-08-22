import '../common_utils/common_utils.dart';
import '../dropdown/dropdown_option_model.dart';

List<DropDownOptionModel> optionsAttendanceApplyPeriodType() => [
      DropDownOptionModel(
          key: 0,
          value: string('option_attendance_apply_period_type.label_today')),
      DropDownOptionModel(
          key: 1,
          value: string('option_attendance_apply_period_type.label_tomorrow')),
      DropDownOptionModel(
          key: 2,
          value: string(
              'option_attendance_apply_period_type.label_specific_date')),
      DropDownOptionModel(
          key: 3,
          value: string(
              'option_attendance_apply_period_type.label_period_of_time')),
    ];

List<DropDownOptionModel> optionsAttendanceApplyTypes() => [
      DropDownOptionModel(
          key: 0, value: string('option_attendance_apply_type.label_absence')),
      DropDownOptionModel(
          key: 1, value: string('option_attendance_apply_type.label_late')),
    ];

List<DropDownOptionModel> optionsAttendanceApplyPeriod() => [
      DropDownOptionModel(
          key: 0,
          value: string('option_attendance_apply_period.label_whole_day')),
      DropDownOptionModel(
          key: 1,
          value: string('option_attendance_apply_period.label_specific_hours')),
    ];

List<DropDownOptionModel> optionsCalenderTypes() => [
      DropDownOptionModel(key: 0, value: string('common_labels.label_day')),
      DropDownOptionModel(key: 1, value: string('common_labels.label_week')),
      DropDownOptionModel(key: 2, value: string('common_labels.label_month')),
    ];

/// messages Filter
List<DropDownOptionModel> optionsHighImportance() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];

List<DropDownOptionModel> optionsRead() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];

List<DropDownOptionModel> optionsSystemNotification() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];

List<DropDownOptionModel> optionsInstituteNotification() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];

/// Homework Filter
List<DropDownOptionModel> optionsHomeworkCompleted() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];

/// Assignment Filter
List<DropDownOptionModel> optionsAssignmentsPassDateDelivery() => [
      DropDownOptionModel(key: -1, value: string("common_labels.label_all")),
      DropDownOptionModel(key: 1, value: string("common_labels.label_yes")),
      DropDownOptionModel(key: 0, value: string("common_labels.label_no")),
    ];
