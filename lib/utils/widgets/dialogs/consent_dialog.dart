import 'package:flutter/material.dart';

import '../../common_utils/common_utils.dart';
import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';
import '../terminologies_utils.dart';

class ConsentDialog {
  static void showAlertDialog(
    BuildContext context,
    bool barrierDismissible, {
    Function()? onPositiveButtonClicked,
  }) {
    Widget consentButton = TextButton(
      onPressed: onPositiveButtonClicked ?? () => Navigator.of(context).pop(),
      child: Text(string('operation.label_go_to_consent'),
          style:
              styleSmall4Medium.copyWith(color: themeOf().themedPrimaryColor)),
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: themeOf().dialogBgColor,
      title: Text(consentsLiteral(),
          style:
              styleSmall4Medium.copyWith(color: themeOf().themedPrimaryColor)),
      content: Text(
          string('operation.warning_unanswered_consent',
              {"consents": consentsLiteral()}),
          style: styleSmall.copyWith(color: themeOf().themedTextColor)),
      actions: [
        consentButton,
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return barrierDismissible;
            },
            child: alert);
      },
    );
  }
}
