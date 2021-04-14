import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

/// The settings page.
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (BuildContext context, SettingsViewModel vm, Widget child) => Scaffold(
        appBar: CustomAppBar(name: 'Settings').build(context),
        body: ListView(
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
              title: Text('Delete stored data'),
              subtitle: Text('This will remove any data this app has stored on your device.'),
              onTap: vm.deleteDeviceData,
            ),
            ListTile(
              title: Text('Terms and Conditions'),
              onTap: vm.showTermsAndConditions,
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: vm.showPrivacyPolicy,
            ),
            if (vm.about != null)
              AboutListTile(
                applicationName: vm.about.appName,
                applicationVersion: vm.about.version,
                applicationLegalese: vm.about.appLegalese,
              ),
          ],
        ),
      ),
    );
  }
}
