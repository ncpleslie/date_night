import 'package:date_night/ui/views/plan_a_date/single/plan_a_date_single_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:date_night/ui/widgets/dumb_widgets/selection_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

/// The Plan a Date page.
class PlanADateSingleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanADateSingleViewState();
  }
}

class _PlanADateSingleViewState extends State<PlanADateSingleView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanADateSingleViewModel>.reactive(
      viewModelBuilder: () => PlanADateSingleViewModel(),
      builder: (BuildContext context, PlanADateSingleViewModel model, Widget? child) => SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
                  name: '',
                  transparent: true,
                  icon: model.isAnyEditorsListValid() ? _deleteAllButton(model) : Container())
              .build(context) as PreferredSizeWidget,
          body: PageBackground(child: _buildSelectionButtons(model)),
          floatingActionButton: Padding(padding: EdgeInsets.only(bottom: 50), child: _buildFinishButton(model)),
        ),
      ),
    );
  }

  Widget _deleteAllButton(PlanADateSingleViewModel model) {
    final double buttonSize = 35;
    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: InkWell(
          customBorder: new CircleBorder(),
          splashColor: Colors.black26,
          onTap: () => model.clearAllLists(),
          onTapDown: (TapDownDetails details) {},
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxHeight: buttonSize, maxWidth: buttonSize, minHeight: buttonSize, minWidth: buttonSize),
            padding: EdgeInsets.all(0),
            child: FaIcon(
              FontAwesomeIcons.trash,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  /// Create the finish button to take the user to the loading page
  /// so their date can be calculated.
  Widget _buildFinishButton(PlanADateSingleViewModel model) {
    return model.isAnyEditorsListValid()
        ? FloatingActionButton(
            child: Icon(
              Icons.keyboard_arrow_right,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: model.navigateToLoading,
          )
        : Container();
  }

  /// Create the selectin buttons
  Widget _buildSelectionButtons(PlanADateSingleViewModel model) {
    return Column(
      children: <Widget>[
        SelectionButton(
            context: context,
            text: 'Person One',
            disabled: model.isSelectedEditorsListValid(0),
            onTap: () => model.navigateToEditScreen(0)),
        const SizedBox(
          height: 1.0,
        ),
        SelectionButton(
            context: context,
            text: 'Person Two',
            disabled: model.isSelectedEditorsListValid(1),
            onTap: () => model.navigateToEditScreen(1)),
        const SizedBox(
          height: 45.0,
        ),
      ],
    );
  }
}
