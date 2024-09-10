import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../../remote/repository/learning/response/teacher_available_response.dart';
import '../../../../remote/repository/learning/response/teacher_list_response.dart';
import '../../../../utils/common_utils/common_utils.dart';
import '../../../../utils/constants/app_styles.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/widgets/divider_widget.dart';
import '../../../../utils/widgets/filter_dialog/common_filter_screen.dart';
import '../../../../utils/widgets/terminologies_utils.dart';

class TeacherInfoDialogWidget extends StatelessWidget {
  final Function() onCloseTapped;
  final List<TeacherAvailableListResponse> availableHours;
  final TeacherListResponse teacher;

  const TeacherInfoDialogWidget(
      {super.key,
      required this.teacher,
      required this.availableHours,
      required this.onCloseTapped});

  Widget contentWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvailableHours(),
          buildSubjectsChipWidget(),
        ],
      ),
    );
  }

  Widget buildAvailableHours() {
    if (availableHours.isNotEmpty) {
      return Container(
        margin: EdgeInsetsDirectional.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              string('common_labels.label_available_hours'),
              style: styleSmall4SemiBold.copyWith(
                  color: themeOf().textFieldHeaderColor),
            ),
            SizedBox(
              height: 12.h,
            ),
            ListView.builder(
                itemCount: availableHours.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildAvailableHoursRow(availableHours[index]);
                })
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildAvailableHoursRow(TeacherAvailableListResponse response) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              response.day ?? "",
              style: styleSmall4Regular.copyWith(
                  color: themeOf().textSecondaryColor),
            )),
            Text(
              "${response.timeFrom ?? ""} - ${response.timeTo ?? ""}",
              style: styleSmall4SemiBold.copyWith(
                  color: themeOf().textPrimaryColor),
            ),
          ],
        ),
        DividerWidget(
          verticalMargin: 12.h,
          color: themeOf().dividerColor,
        ),
      ],
    );
  }

  Widget buildSubjectsChipWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subjectsLiteral(),
          style: styleSmall4SemiBold.copyWith(
              color: themeOf().textFieldHeaderColor),
        ),
        SizedBox(
          height: 12.h,
        ),
        buildSubjectsChip()
      ],
    );
  }

  Widget buildSubjectsChip() {
    List<JobRole> subjects = teacher.teacherSubjects ?? [];

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        children: subjects.map((subject) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
                color: themeOf().markViewBgColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: themeOf().markViewBorderColor)),
            child: Text(
              subject.description ?? "",
              style:
                  styleSmall2Medium.copyWith(color: themeOf().textPrimaryColor),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CommonFilterScreen(
        filterTitleText: teacher.fullname ?? "",
        filterButtonText: "",
        contentWidget: contentWidget(),
        onCloseTapped: () {},
        onButtonTapped: () {},
      ),
    );
  }
}
