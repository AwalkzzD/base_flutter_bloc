import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/user/response/student_relative_extended.dart';
import '../appbar/common_profile_view.dart';
import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import 'image_view.dart';

class StudentListPopoverWidget extends StatefulWidget {
  final Function(StudentForRelativeExtended?)? onStudentClick;
  final BehaviorSubject<StudentForRelativeExtended?>? student;
  final List<StudentForRelativeExtended?>? studentsList;

  const StudentListPopoverWidget(
      {super.key, this.student, this.onStudentClick, this.studentsList});

  @override
  State<StudentListPopoverWidget> createState() =>
      _StudentListPopoverWidgetState();
}

class _StudentListPopoverWidgetState extends State<StudentListPopoverWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StudentForRelativeExtended?>(
        stream: widget.student?.stream,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                start: 16.h, end: 16.h, bottom: 16.h, top: 16.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.zero,
              itemCount: widget.studentsList?.length ?? 0,
              itemBuilder: (context, index) {
                return buildStudentItemWidget(
                    widget.studentsList?[index], snapshot.data);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8.h);
              },
            ),
          );
        });
  }

  Widget buildStudentItemWidget(StudentForRelativeExtended? data,
      StudentForRelativeExtended? selectedStudent) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        widget.onStudentClick?.call(data);
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(
            start: 6.h, end: 6.h, top: 6.h, bottom: 6.h),
        color: selectedStudent?.student.id == data?.student.id
            ? themeOf().cardHighlightBgColor
            : themeOf().appBarColor,
        child: Column(
          children: [
            Row(
              children: [
                CommonProfileView(
                  image: data?.image ?? "",
                  text: data?.fullName ?? "",
                  size: 40.h,
                  imageShape: ImageShape.circle,
                  boxFit: BoxFit.cover,
                  borderWidth: 0,
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 16.h),
                  child: Text(
                    data?.fullName ?? "",
                    style: styleMedium1.copyWith(
                        color: themeOf().textSecondaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
