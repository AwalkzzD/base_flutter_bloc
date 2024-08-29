import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/dialogs/progress_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../common_utils/common_utils.dart';
import '../../stream_helper/launcher_utils.dart';

class CustomHtmlView extends StatelessWidget {
  final String data;
  final bool shrinkWrap;
  final Color? textColor;
  final Color? textBackgroundColor;

  const CustomHtmlView(this.data,
      {this.shrinkWrap = false,
      this.textColor,
      this.textBackgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (isTablet()) {
      return HtmlWidget(
        data,
        onLoadingBuilder: (context, element, loadingProgress) {
          return const Center(child: ProgressView());
        },
        onTapUrl: (url) {
          openUrl(url);
          return false;
        },
        factoryBuilder: () => CustomWidgetFactory(
            textColor: textColor, backgroundColor: textBackgroundColor),
        textStyle: TextStyle(fontSize: 15.sp, color: textColor),
      );
    } else {
      return HtmlWidget(
        data,
        onLoadingBuilder: (context, element, loadingProgress) {
          return const Center(child: ProgressView());
        },
        onTapUrl: (url) {
          openUrl(url);
          return false;
        },
        factoryBuilder: () => CustomWidgetFactory(
            textColor: textColor, backgroundColor: textBackgroundColor),
        textStyle: TextStyle(color: textColor),
      );
    }
    /*return Html(
      shrinkWrap: shrinkWrap,
      style: {
        "html": Style(
          direction: getLanguage() == "ar-EG" ? TextDirection.rtl : TextDirection.ltr,
        ),
        "body": Style(
            direction: getLanguage() == "ar-EG" ? TextDirection.rtl : TextDirection.ltr,
            padding: HtmlPaddings.zero,
            margin: Margins.zero),
        "p": Style( direction: getLanguage() == "ar-EG" ? TextDirection.rtl : TextDirection.ltr,padding: HtmlPaddings.zero, margin: Margins.zero),
      },
      onLinkTap: (String? url, Map<String, String> attributes, element) {
        openUrl(url);
      },
      data: data,
    );*/
  }
}

class CustomWidgetFactory extends WidgetFactory {
  final Color? textColor;
  final Color? backgroundColor;

  CustomWidgetFactory({this.textColor, this.backgroundColor});

  @override
  Widget? buildDecoration(BuildTree tree, Widget child,
      {BoxBorder? border,
      BorderRadius? borderRadius,
      Color? color,
      DecorationImage? image}) {
    if (backgroundColor != null) {
      color = backgroundColor;
    }
    return super.buildDecoration(tree, child,
        border: border, borderRadius: borderRadius, color: color, image: image);
  }

  @override
  InlineSpan? buildTextSpan(
      {List<InlineSpan>? children,
      GestureRecognizer? recognizer,
      TextStyle? style,
      String? text}) {
    if (recognizer == null) {
      if (textColor != null) {
        style = style?.copyWith(color: textColor);
      }
      if (backgroundColor != null) {
        style = style?.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: backgroundColor,
            background: Paint()..color = backgroundColor!);
      }
    }
    return super.buildTextSpan(
        children: children, recognizer: recognizer, style: style, text: text);
  }
}
