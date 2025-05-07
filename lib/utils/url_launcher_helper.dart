import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchURL(
    String url, 
    {bool inNewTab = true, bool enableDomStorage = true}
  ) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        webOnlyWindowName: inNewTab ? '_blank' : '_self',
        webViewConfiguration: WebViewConfiguration(
          enableDomStorage: enableDomStorage,
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchEmail(String email, {String? subject, String? body}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: <String, String>{
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  static Future<void> launchPhone(String phone) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }
} 