import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/cupertino.dart';

class CustomImageCheckbox extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget activeImage;
  final Widget inactiveImage;
  final bool? initialValue;
  final ValueChanged<bool> onChanged;

  const CustomImageCheckbox({
    super.key,
    required this.title,
    this.titleStyle,
    required this.activeImage,
    required this.inactiveImage,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CustomImageCheckboxState();
}

class _CustomImageCheckboxState extends State<CustomImageCheckbox> {
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    valueNotifier.value = widget.initialValue ?? false;
  }

  void _toggleValue() {
    valueNotifier.value = !valueNotifier.value;
    widget.onChanged(valueNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleValue,
      child: ValueListenableBuilder<bool>(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return Row(
            children: [
              value ? widget.activeImage : widget.inactiveImage,
              SizedBox(width: 8.w),
              Text(
                widget.title,
                style: widget.titleStyle ?? const TextStyle(),
              ),
            ],
          );
        },
      ),
    );
  }
}
