import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/dates_around_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:model/main.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/page_background.dart';

/// Dates Around displays the winning date idea of other users
/// along with their non-winning ideas.
/// This screen will pull these ideas from the DB and display
/// them in a list of cards.
class DatesAroundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar:
              CustomAppBar(name: 'Dates Around', icon: _settingsIcon(context))
                  .build(context),
          body: PageBackground(
            child: DatesAroundListView(
              model: model,
            ),
          ),
        );
      },
    );
  }

  /// The settings icon display in the AppBar.
  /// Will take the user to the settings page.
  Widget _settingsIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () => Navigator.of(context).pushNamed(Routes.Settings),
    );
  }
}
