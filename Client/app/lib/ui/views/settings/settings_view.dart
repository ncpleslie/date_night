import 'package:date_night/config/about.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

/// The settings page.
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.nonReactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (BuildContext context, SettingsViewModel model, Widget child) =>
          Scaffold(
        appBar: CustomAppBar(name: 'Settings').build(context),
        body: FutureBuilder(
            future: _getAppInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<AboutModel> snapshot) {
              return ListView(
                children: [
                  // Removed as dark mode not yet supported

                  // ListTile(
                  //   title: Text('Toggle Light/Dark Mode'),
                  //   trailing: Switch.adaptive(
                  //     activeTrackColor: Colors.green,
                  //     activeColor: Colors.white,
                  //     value: model.isLightMode,
                  //     onChanged: (bool state) =>
                  //         _toggleLightMode(model, state),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text('Use System Light/Dark Mode'),
                  //   trailing: Switch.adaptive(
                  //     activeTrackColor: Colors.green,
                  //     activeColor: Colors.white,
                  //     value: model.isSystemLightDarkMode,
                  //     onChanged: (bool state) =>
                  //         _toggleSystemLightDarkMode(model, state),
                  //   ),
                  // ),
                  if (snapshot.data != null)
                    AboutListTile(
                      applicationName: snapshot.data.appName,
                      applicationVersion: snapshot.data.version,
                      applicationLegalese: snapshot.data.appLegalese,
                    ),
                ],
              );
            }),
      ),
    );
  }

  Future<AboutModel> _getAppInfo() async {
    return About.packageInfo();
  }

  // void _toggleLightMode(MainModel model, bool state) {
  //   setState(() {
  //     model.toggleIsLightMode(state);
  //   });
  // }

  // void _toggleSystemLightDarkMode(MainModel model, bool state) {
  //   setState(() {
  //     model.toggleIsSystemLightDarkMode(state);
  //   });
  // }
}
