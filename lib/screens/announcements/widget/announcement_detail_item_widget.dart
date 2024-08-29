import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/announcements/announcement_central/response/announcements_list_response.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/date/date_util.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/divider_widget.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/image_view.dart';

class AnnouncementDetailItemWidget extends StatelessWidget {
  final AnnouncementsListResponse data;
  final TextStyle titleStyle;
  final bool showButton;
  final bool readData;

  const AnnouncementDetailItemWidget(
      {super.key,
      required this.data,
      required this.titleStyle,
      required this.showButton,
      required this.readData});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.h),
        decoration: (showButton)
            ? BoxDecoration(
                color: (readData)
                    ? themeOf().cardHighlightBgColor
                    : themeOf().cardBgColor,
                border: Border.all(color: themeOf().cardBorderColor),
                borderRadius: BorderRadius.circular(10))
            : const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSubjectText(),
            DividerWidget(
              verticalMargin: 10.h,
              color: themeOf().dividerColor,
            ),
            Row(
              children: [
                getLocationWidget(),
                Expanded(child: buildTimeRangeText(data)),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            buildShortDescription(data.shortDescription),
            getDetailsButton(context)
          ],
        ));
  }

  Widget getPinCodeLabel(String pinCode) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(0, 0, 10.h, 0),
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
      decoration: BoxDecoration(
          color: themeOf().textFieldBgColor,
          border: Border.all(color: themeOf().textFieldBorderColor),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          ImageView(
            image: AppImages.icPin,
            imageType: ImageType.svg,
            width: 9.h,
            height: 12.h,
            color: themeOf().iconColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            pinCode,
            style:
                styleSmall2Medium.copyWith(color: themeOf().textPrimaryColor),
          )
        ],
      ),
    );
  }

  String getFormattedTime(DateTime time) {
    return SPDateUtils.format(time, SPDateUtils.FORMAT_HHMM_AMPM) ?? '';
  }

  String getTimeToGoText(DateTime startDate) {
    var time = SPDateUtils.getTimeDifferenceString(startDate);
    if (time.isEmpty) {
      return '';
    } else {
      return ' | $time';
    }
  }

  Widget buildViewDetailsButton(
      BuildContext context, int eventId, bool isRead) {
    return GradientButton(
      height: 28.h,
      gradient: getCommonGradient(),
      onPressed: () {
        // Navigator.of(context).push(AnnouncementDetailsScreen.route(eventId, isRead));
      },
      borderRadius: BorderRadius.circular(6),
      child: Text(
        string("announcements.label_view_details"),
        style: styleSmall2Medium.copyWith(
          color: white,
        ),
      ),
    );
  }

  Widget buildShortDescription(String? description) {
    if (description != null && description.isNotEmpty) {
      return Text(
        description,
        style: styleSmall2.copyWith(color: themeOf().textPrimaryColor),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildTimeRangeText(AnnouncementsListResponse data) {
    String startTime = getFormattedTime(data.startDate!);
    String endTime = getFormattedTime(data.endDate!);
    String timeToGo = getTimeToGoText(data.startDate!);

    String timeRangeText = '$startTime - $endTime';
    if (timeToGo.isNotEmpty) {
      timeRangeText += timeToGo;
    }

    return Text(
      timeRangeText,
      style: styleSmall2.copyWith(color: themeOf().textPrimaryColor),
    );
  }

  Widget getLocationWidget() {
    if (data.location?.isNotEmpty == true) {
      return getPinCodeLabel(data.location ?? '');
    } else {
      return const SizedBox();
    }
  }

  Widget getSubjectText() {
    return Text(
      data.subject ?? '',
      style: titleStyle,
    );
  }

  Widget getDetailsButton(BuildContext context) {
    if (showButton) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          buildViewDetailsButton(context, data.id ?? 0, data.isRead ?? false)
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
