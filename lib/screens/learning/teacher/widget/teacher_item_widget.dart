import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../../remote/repository/learning/response/teacher_list_response.dart';
import '../../../../utils/appbar/common_profile_view.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_styles.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/widgets/divider_widget.dart';
import '../../../../utils/widgets/gradient_overlay.dart';
import '../../../../utils/widgets/image_view.dart';

class TeacherItemWidget extends StatefulWidget {
  final int index;
  final TeacherListResponse? data;
  final Function(TeacherListResponse) onAvailabilityTap;
  final Function(TeacherListResponse) onSubjectTap;

  const TeacherItemWidget(this.data, this.index,
      {super.key, required this.onSubjectTap, required this.onAvailabilityTap});

  @override
  State<TeacherItemWidget> createState() => _TeacherItemWidgetState();
}

class _TeacherItemWidgetState extends State<TeacherItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: themeOf().cardBgColor,
          border: Border.all(color: themeOf().cardBorderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          buildThumbnailWidget(),
          buildDetailsWidget(),
        ],
      ),
    );
  }

  Widget buildButton(String iconData, Function() onTapped) {
    return IconButton(
      onPressed: onTapped,
      padding: EdgeInsetsDirectional.all(10.h),
      constraints: const BoxConstraints(),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: ImageView(
        image: iconData,
        imageType: ImageType.svg,
        height: 16.h,
        width: 16.h,
        color: themeOf().iconColor,
      ),
    );
  }

  Widget buildButtonsWidget() {
    return Column(
      children: [
        SizedBox(height: 10.h),
        const DividerWidget(verticalMargin: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.data?.showAvailableHours == true
                ? buildButton(AppImages.icTeachersTimetable, () {
                    widget.onAvailabilityTap.call(widget.data!);
                  })
                : const SizedBox(),
            /*buildButton(AppImages.icTeacherMail, () {
              showMessageBar('email tapped');
            }),*/
            buildButton(AppImages.icTeachersChat, () async {
              /*final result = await Navigator.of(context, rootNavigator: true).push(SendMessageScreen.route(
                  subject: "",
                  recipients: [Sender(
                      id: widget.data?.id,
                      givenName: widget.data?.givenName,
                      surname: widget.data?.surname,
                      image: "")])
              );*/
            }),
          ],
        ),
      ],
    );
  }

  Widget buildThumbnailWidget() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      child: SizedBox(
        height: 150.h,
        child: Stack(
          children: [
            CommonProfileView(
              image: widget.data?.image ?? "",
              text: "${widget.data?.fullname}",
              boxFit: BoxFit.cover,
              borderWidth: 0,
              borderRadius: 0,
              size: double.infinity,
              height: double.infinity,
            ),
            const GradientOverlay(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 10.h),
                child: Text(
                  widget.data?.jobRole?.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: styleSmall.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContent(),
          buildButtonsWidget(),
        ],
      ),
    );
  }

  Widget buildContent() {
    String subjects = "";
    if (widget.data?.teacherSubjects?.isNotEmpty == true) {
      subjects = widget.data?.teacherSubjects
              ?.map((e) => e.description)
              .toList()
              .join(", ") ??
          "";
    }
    return Container(
      margin: EdgeInsetsDirectional.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${widget.data?.fullname}",
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                styleSmall3SemiBold.copyWith(color: themeOf().textPrimaryColor),
          ),
          /*widget.data?.email!=null && widget.data?.email?.isNotEmpty==true ? Container(
            padding: EdgeInsets.only(bottom: 1.h),
            child: InkWell(
              onTap: (){
                openURL("mailto:${widget.data?.email}");
              },
              child: Text(
                "${widget.data?.email}",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: styleSmall2Medium.copyWith(color: themeOf().textPrimaryColor,decoration: TextDecoration.underline),
              ),
            ),
          ) : const SizedBox(),*/
          subjects.isNotEmpty == true
              ? GestureDetector(
                  onTap: () {
                    widget.onSubjectTap.call(widget.data!);
                  },
                  child: Text(subjects,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: styleSmall2Medium.copyWith(
                          color: themeOf().textSecondaryColor)),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
