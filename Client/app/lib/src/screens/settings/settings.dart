import 'package:date_night/src/config/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../widgets/custom_app_bar.dart';

/// The settings page.
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: CustomAppBar(name: 'Settings').build(context),
          body: FutureBuilder(
              future: _getAppInfo(),
              builder:
                  (BuildContext context, AsyncSnapshot<AboutModel> snapshot) {
                return ListView(
                  children: [
                    ListTile(
                      title: Text('Toggle Light/Dark Mode'),
                      trailing: Switch.adaptive(
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                        value: model.isLightMode,
                        onChanged: (bool state) =>
                            _toggleLightMode(model, state),
                      ),
                    ),
                    ListTile(
                      title: Text('Use System Light/Dark Mode'),
                      trailing: Switch.adaptive(
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                        value: model.isSystemLightDarkMode,
                        onChanged: (bool state) =>
                            _toggleSystemLightDarkMode(model, state),
                      ),
                    ),
                    if (snapshot.data != null)
                      AboutListTile(
                        applicationName: snapshot.data.appName,
                        applicationVersion: snapshot.data.version,
                        applicationLegalese: snapshot.data.appLegalese,
                      ),
                  ],
                );
              }),
        );
      },
    );
  }

  Future<AboutModel> _getAppInfo() async {
    return About.packageInfo();
  }

  void _toggleLightMode(MainModel model, bool state) {
    setState(() {
      model.toggleIsLightMode(state);
    });
  }

  void _toggleSystemLightDarkMode(MainModel model, bool state) {
    setState(() {
      model.toggleIsSystemLightDarkMode(state);
    });
  }
}

// Center(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: const <Widget>[
//               Text('Created By Nick Leslie'),
//               Text('All Rights Reserved'),
//               Text('©')
//             ],
//           ),
//         ),
//       ),
