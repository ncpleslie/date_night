import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

/// The settings page.
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (BuildContext context, SettingsViewModel model, Widget child) =>
          Scaffold(
        appBar: CustomAppBar(name: 'Settings').build(context),
        body: 
               ListView(
                children: [
                  // Disable because there is no theme switching yet

                  // ListTile(
                  //   leading: FaIcon(FontAwesomeIcons.adjust),
                  //   title: Text('Light/Dark Mode'),
                  //   trailing: Switch.adaptive(
                  //       activeTrackColor: Colors.green,
                  //       activeColor: Colors.white,
                  //       value: model.isLightMode,
                  //       onChanged: (bool state) => model.toggleLightMode()),
                  // ),

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.trash),
                    title: Text('Delete stored data'),
                    subtitle: Text(
                        'This will remove any data this app has stored on your device. This is good to use when you are having issue with this application.'),
                    onTap: () => model.deleteDeviceData(),
                  ),
                  if (model.about != null)
                    AboutListTile(
                      icon: FaIcon(FontAwesomeIcons.handPointRight),
                      applicationName: model.about.appName,
                      applicationVersion: model.about.version,
                      applicationLegalese: model.about.appLegalese,
                    ),
                ],
              ),
        
      ),
    );
  }
}
