import 'package:core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static AsyncResult<void> launchExternally(Uri uri) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(UrlLauncherException());
    }
  }
}

class UrlLauncherException implements Exception {}
