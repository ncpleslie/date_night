import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/ideas_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/selection_button.dart';
import './date_add.dart';

class PlanADate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanADateState();
  }
}

class _PlanADateState extends State<PlanADate> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget widget, IdeasModel model) {
        return Scaffold(
          appBar: CustomAppBar(
                  'Plan A Date',
                  model.isAnyEditorsListValid()
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
          floatingActionButton: _buildFAB(model),
        );
      },
    );
  }

  Widget _buildSelectionButtons(IdeasModel model) {
    return Column(
      children: <Widget>[
        SelectionButton(
            context,
            'Person One',
            model.isSelectedEditorsListValid(0),
            () => _navigateToEdit(model, 0)),
        const SizedBox(
          height: 1.0,
        ),
        SelectionButton(
            context,
            'Person Two',
            model.isSelectedEditorsListValid(1),
            () => _navigateToEdit(model, 1)),
      ],
    );
  }

  /// Will navigate to the correct editting page based on is currently editing
  void _navigateToEdit(IdeasModel model, int whoIsEditing) {
    model.setCurrentEditor(whoIsEditing);
    print('Route change called');
    Navigator.push<void>(
        context, MaterialPageRoute<bool>(builder: (_) => DateAdd()));
  }

  Widget _buildFAB(IdeasModel model) {
    return model.isAnyEditorsListValid()
        ? FloatingActionButton(
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.Loading);
            },
          )
        : Container();
  }
}
