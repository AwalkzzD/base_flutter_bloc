import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../common_utils/common_utils.dart';

class PaginateErrorWidget extends StatelessWidget {
  final Exception exception;
  final Function() tryAgain;

  const PaginateErrorWidget(this.exception, this.tryAgain, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 12.h, top: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            exception.toString(),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: tryAgain,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
              child: Text(
                string("common_labels.retry"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
