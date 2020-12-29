import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/custom_app_bar.dart';

/// The settings page.
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(name: 'Settings').build(context),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text('Created By Nick Leslie'),
              Text('All Rights Reserved'),
              Text('©')
            ],
          ),
        ),
      ),
    );
  }
}
