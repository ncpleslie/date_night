import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:stacked/stacked.dart';

import 'boot_viewmodel.dart';

/// This page is to perform functions before the app starts up.
/// This includes login the user in.
class BootView extends StatelessWidget {
  const BootView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BootViewModel>.reactive(
        viewModelBuilder: () => BootViewModel(),
        builder: (BuildContext context, BootViewModel model, Widget child) {
          if (model.isBusy) return _isBusy();
          if (model.hasError) return _hasError(context);
          return _hasError(context);
        });
  }

  Widget _hasError(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'An error has occured starting this application.\nIf this continues, ensure you have an active internet connection.',
              textAlign: TextAlign.center,
            ),
            TextButton(
              child: Text('Restart'),
              onPressed: () => {Phoenix.rebirth(context)},
            )
          ],
        ),
      ),
    );
  }

  Widget _isBusy() {
    return Scaffold(
      body: PageBackground(
        child: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
