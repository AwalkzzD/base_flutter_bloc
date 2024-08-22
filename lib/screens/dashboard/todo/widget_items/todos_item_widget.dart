import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../remote/repository/todo/response/session_task_list_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_styles.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/date/date_util.dart';

class TodosItemWidget extends StatefulWidget {
  final SessionTaskListResponse? data;

  const TodosItemWidget({this.data, super.key});

  @override
  State<TodosItemWidget> createState() => _TodosItemWidgetState();
}

class _TodosItemWidgetState extends State<TodosItemWidget> {
  @override
  Widget build(BuildContext context) {
    String subject = "";
    String group = "";
    String period = "";
    String classroom = "";
    if (widget.data?.subjects?.isNotEmpty == true) {
      subject = widget.data?.subjects
              ?.map((e) => e.description ?? "")
              .toList()
              .join(", ") ??
          "";
    }
    if (widget.data?.groups?.isNotEmpty == true) {
      group = widget.data?.groups
              ?.map((e) => e.description ?? "")
              .toList()
              .join(", ") ??
          "";
    }
    if (widget.data?.periods?.isNotEmpty == true) {
      period =
          "${SPDateUtils.format(widget.data?.startDate, SPDateUtils.FORMAT_HHMM)}-${SPDateUtils.format(widget.data?.endDate, SPDateUtils.FORMAT_HHMM)}";
    }
    if (widget.data?.classRooms?.isNotEmpty == true) {
      classroom = widget.data?.classRooms
              ?.map((e) => e.description ?? "")
              .toList()
              .join(", ") ??
          "";
    }

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(12.h, 8.h, 12.h, 4.h),
      decoration: BoxDecoration(
        color:
            themeOf().lightMode() ? bulletBorderColor : themeOf().cardBgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        group.isNotEmpty
            ? Container(
                padding: EdgeInsetsDirectional.only(bottom: 4.h),
                child: Text(
                  group,
                  style: styleSmall13Medium.copyWith(
                      color: themeOf().textPrimaryColor),
                ),
              )
            : const SizedBox(),
        subject.isNotEmpty
            ? Container(
                padding: EdgeInsetsDirectional.only(bottom: 4.h),
                child: Text(
                  subject,
                  style: styleSmall2Medium.copyWith(
                      color: themeOf().textPrimaryColor),
                ),
              )
            : const SizedBox(),
        classroom.isNotEmpty
            ? Container(
                padding: EdgeInsetsDirectional.only(bottom: 4.h),
                child: Text(
                  classroom,
                  style: styleSmall2Medium.copyWith(
                      color: themeOf().textPrimaryColor),
                ),
              )
            : const SizedBox(),
        period.isNotEmpty
            ? Container(
                padding: EdgeInsetsDirectional.only(bottom: 4.h),
                child: Text(
                  period,
                  style: styleSmall2Medium.copyWith(
                      color: themeOf().textFieldHeaderColor),
                ),
              )
            : const SizedBox(),
      ]),
    );
  }
}
