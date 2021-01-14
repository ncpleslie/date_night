import 'package:date_night/src/config/theme_data.dart';
import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/screens/plan_a_date/shared/date_add.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:model/main.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/selection_button.dart';

/// The Plan a Date page.
class PlanADateSingle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanADateState();
  }
}

class _PlanADateState extends State<PlanADateSingle> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return Scaffold(
          appBar: CustomAppBar(
                  name: 'Plan A Date',
                  transparent: false,
                  icon: model.isAnyEditorsListValid()
                      ? IconButton(
                          icon: const Icon(CupertinoIcons.delete),
                          tooltip: 'Delete',
                          onPressed: () {
                            model.clearAllLists();
                            setState(() {});
                          },
                        )
                      : Container())
              .build(context),
          body: PageBackground(child: _buildSelectionButtons(model)),
          floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: _buildFinishButton(model)),
        );
      },
    );
  }

  /// Create the finish button to take the user to the loading page
  /// so their date can be calculated.
  Widget _buildFinishButton(MainModel model) {
    return model.isAnyEditorsListValid()
        ? FloatingActionButton(
            child: Icon(
              Icons.keyboard_arrow_right,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: _navigateToNext,
          )
        : Container();
  }

  /// Create the selectin buttons
  Widget _buildSelectionButtons(MainModel model) {
    return Column(
      children: <Widget>[
        SelectionButton(
            context: context,
            text: 'Person One',
            disabled: model.isSelectedEditorsListValid(0),
            onTap: () => _navigateToEdit(model, 0)),
        const SizedBox(
          height: 1.0,
        ),
        SelectionButton(
            context: context,
            text: 'Person Two',
            disabled: model.isSelectedEditorsListValid(1),
            onTap: () => _navigateToEdit(model, 1)),
        const SizedBox(
          height: 45.0,
        ),
      ],
    );
  }

  /// Will navigate to the correct editting page based on is currently editing
  void _navigateToEdit(MainModel model, int whoIsEditing) {
    model.setCurrentEditor(whoIsEditing);
    pushNewScreen(
      context,
      screen: DateAdd(),
      withNavBar: false,
      pageTransitionAnimation: ThemeConfig.pageTransition,
    );
  }

  /// Navigate to the next stage
  Future<void> _navigateToNext() async {
    Navigator.of(context).pushNamed(Routes.Loading);
  }
}
