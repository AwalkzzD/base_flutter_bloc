import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/announcements/announcement_central/response/detail/announcement_detail_response.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';

class AnnouncementCentralItemWidget extends StatefulWidget {
  final AnnouncementDetailResponse? data;

  const AnnouncementCentralItemWidget({super.key, required this.data});

  @override
  State<AnnouncementCentralItemWidget> createState() =>
      _AnnouncementCentralItemWidgetState();
}

class _AnnouncementCentralItemWidgetState
    extends State<AnnouncementCentralItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isTablet() ? 0.5.sw : 0.6.sw,
      margin: EdgeInsetsDirectional.only(end: 8.h),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.h, vertical: 8.h),
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          border: Border.all(color: themeOf().cardBorderColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              widget.data?.title ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  styleSmall3Medium.copyWith(color: themeOf().textPrimaryColor),
            ),
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: Text(
              widget.data?.shortDescription ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  styleSmall2Normal.copyWith(color: themeOf().textPrimaryColor),
            ),
          ),
          SizedBox(height: 4.h),
          InkWell(
            onTap: () {
              /*Navigator.of(context)
                  .push(AnnouncementCentralDetailScreen.route(widget.data));*/
            },
            child: Text(string('common_labels.label_click_here_for_more'),
                style: styleSmall2SemiBold.copyWith(
                  color: themeOf().textAccentColor,
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
