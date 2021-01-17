import 'package:package_info/package_info.dart';

class About {
  static Future<AboutModel> packageInfo() =>
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    return AboutModel.fromPackageInfo(packageInfo);
  });
  static const String appLegalese = 'Created By Nick Leslie\nAll Rights Reserved';
  static const String appName = 'Date Night';
}

class AboutModel {
  AboutModel(
      {this.appName,
      this.packageName,
      this.version,
      this.buildNumber,
      this.appLegalese});
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final String appLegalese;

  factory AboutModel.fromPackageInfo(PackageInfo packageInfo) {
    return AboutModel(
        appName: About.appName,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
        appLegalese: About.appLegalese
        );
  }
}
