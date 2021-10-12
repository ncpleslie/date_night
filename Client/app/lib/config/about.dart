import 'package:date_night/config/globals.dart';
import 'package:package_info/package_info.dart';

class About {
  static Future<AboutModel> packageInfo() =>
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    return AboutModel.fromPackageInfo(packageInfo);
  });
  static const String appLegalese = 'Created By Nick Leslie\nAll Rights Reserved';
}

class AboutModel {
  AboutModel(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber,
      required this.appLegalese});
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final String appLegalese;

  factory AboutModel.fromPackageInfo(PackageInfo packageInfo) {
    return AboutModel(
        appName: Globals.APP_NAME,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
        appLegalese: About.appLegalese
        );
  }
}
