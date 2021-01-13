import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/dates_around_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:model/main.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/page_background.dart';

/// Dates Around displays the winning date idea of other users
/// along with their non-winning ideas.
/// This screen will pull these ideas from the DB and display
/// them in a list of cards.
class DatesAroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DatesAroundPageState();
  }
}

class _DatesAroundPageState extends State<DatesAroundPage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
                  name: 'Dates Around',
                  icon: _settingsIcon(context),
                  transparent: true,
                  scrollable: true,
                  scrollController: controller)
              .build(context),
          body: PageBackground(
            child: Snap(
              controller: controller.appBar,
              child: DatesAroundListView(
                controller: controller,
                model: model,
              ),
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
