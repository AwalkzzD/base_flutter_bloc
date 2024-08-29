import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/consents/response/consents_student_response.dart';
import '../../../utils/common_utils/shared_pref.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/widgets/bullet_view.dart';

class UnansweredConsentItem extends StatelessWidget {
  final int userId;
  final List<ConsentsStudentsResponse> consentsList;
  final Function(ConsentsStudentsResponse) onConsentTap;

  const UnansweredConsentItem({
    super.key,
    required this.userId,
    required this.consentsList,
    required this.onConsentTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 24.h, top: 14.h, end: 24.h),
        padding: EdgeInsetsDirectional.only(
            start: 12.h, top: 12.h, bottom: 12.h, end: 12.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            border: Border.all(color: themeOf().cardBorderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getUsernameById(userId),
                style: styleSmall3Medium.copyWith(
                    color: themeOf().textPrimaryColor)),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 10.h),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: consentsList.length,
                itemBuilder: (context, index) {
                  final consent = consentsList[index];
                  return InkWell(
                    onTap: () {
                      onConsentTap(consent);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4.h, 0, 4.h),
                      child: Row(
                        children: [
                          BulletView(height: 10.h, width: 10.h),
                          Flexible(
                            child: Text(consent.description ?? '',
                                style: styleSmall2SemiBold.copyWith(
                                  color: themeOf().textAccentColor,
                                  decoration: TextDecoration.underline,
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
