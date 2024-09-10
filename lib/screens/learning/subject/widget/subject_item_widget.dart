import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../remote/repository/learning/response/learning_student_response.dart';
import '../../../../utils/common_utils/common_utils.dart';
import '../../../../utils/common_utils/shared_pref.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_styles.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/dropdown/custom_dropdown.dart';
import '../../../../utils/dropdown/dropdown_option_model.dart';
import '../../../../utils/stream_helper/launcher_utils.dart';
import '../../../../utils/widgets/divider_widget.dart';
import '../../../../utils/widgets/image_view.dart';

class SubjectItemWidget extends StatefulWidget {
  final LearningStudentResponse? data;
  final int index;
  final Function(LearningStudentResponse) onTapped;

  const SubjectItemWidget(this.data, this.index,
      {super.key, required this.onTapped});

  @override
  State<SubjectItemWidget> createState() => _SubjectItemWidgetState();
}

class _SubjectItemWidgetState extends State<SubjectItemWidget> {
  List<DropDownOptionModel> learningRooms = [];
  DropDownOptionModel? selectedGroup;

  @override
  void initState() {
    super.initState();
    learningRooms = widget.data?.learningRooms
            ?.map((e) => DropDownOptionModel(key: e.id, value: e.title))
            .toList() ??
        [];
    if (learningRooms.isNotEmpty) {
      selectedGroup = learningRooms.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTapped(widget.data!);
      },
      child: Container(
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
            // buildButton(AppImages.icSubjectNotification, () {}),
            buildButton(AppImages.icSubjectShare, () {
              if (widget.data?.microsoft365Url != null &&
                  widget.data?.microsoft365Url?.isNotEmpty == true) {
                openUrl(widget.data?.microsoft365Url);
              }
            }),
            buildButton(AppImages.icSubjectLink, () {}),
          ],
        ),
      ],
    );
  }

  Widget buildThumbnailWidget() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      child: ImageView(
        image: widget.data?.imageUrl ?? "",
        imageType: ImageType.network,
        boxFit: BoxFit.fill,
        height: 120.h,
        width: double.infinity,
      ),
    );
  }

  Widget buildDetailsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //buildLearningRooms(),
            buildContent(),
            buildButtonsWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${widget.data?.subject?.description}",
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                styleSmall3SemiBold.copyWith(color: themeOf().textPrimaryColor),
          ),
          widget.data?.description?.isNotEmpty == true
              ? Text(widget.data?.description ?? "",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: styleSmall2Medium.copyWith(
                      color: themeOf().textSecondaryColor))
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget buildLearningRooms() {
    return learningRooms.isNotEmpty
        ? Container(
            margin: EdgeInsetsDirectional.only(top: 0.h),
            child: CustomDropdown(
                hint: string('common_labels.label_learning_rooms'),
                items: learningRooms,
                initialValue: selectedGroup,
                hintStyle:
                    styleSmall1.copyWith(color: themeOf().dropdownHintColor),
                dropDownTextStyle:
                    styleSmall2.copyWith(color: themeOf().dropdownHintColor),
                isExpanded: true,
                isDense: false,
                maxLines: 1,
                menuItemStyleData: MenuItemStyleData(
                  height: 34.h * getScaleFactor(),
                  padding: EdgeInsetsDirectional.only(start: 4.h, end: 4.h),
                ),
                dropdownStyleData: DropdownStyleData(
                  padding: const EdgeInsetsDirectional.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.h),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  height: 34.h * getScaleFactor(),
                  padding: EdgeInsetsDirectional.only(
                      start: 0, end: 6.h, top: 0, bottom: 0.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: themeOf().dropdownBorderColor),
                    ),
                  ),
                ),
                onClick: (val) {}),
          )
        : const SizedBox();
  }
}
