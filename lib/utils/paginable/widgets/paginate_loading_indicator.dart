import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

class PaginateLoadingIndicatorWidget extends StatelessWidget {
  const PaginateLoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 12.h, top: 12.h),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
