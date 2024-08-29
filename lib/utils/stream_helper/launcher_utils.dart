import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String? url) async {
  if (url != null && url.isNotEmpty) {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showToast('Could not launch $url');
    }
  }
}
