import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:model/main.dart';
import 'package:scoped_model/scoped_model.dart';

import 'index.dart';

/// This page is to perform functions before the app starts up.
/// This includes login the user in.
class Boot extends StatelessWidget {
  const Boot({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FutureBuilder(
          future: model.signInAnon(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.hasData) {
              return Index();
            }
            if (snapshot.hasError) {
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
            return Scaffold(
              body: PageBackground(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
