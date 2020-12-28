import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../scoped_model/main_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_screen_icon.dart';
import '../../widgets/page_background.dart';

/// DateAdd allows the user to add a new date.
/// The user can tap the "add" button to enter new ideas.
/// They can swipe away bad ideas, or tap delete.
/// Once they have finished they can tap the finish icon to
/// return back to the 'Plan A Date' screen.
class DateAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DateAddState();
  }
}

class _DateAddState extends State<DateAdd> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return Scaffold(
          // Build Appbar
          appBar: CustomAppBar('', Container()).build(context),
          resizeToAvoidBottomPadding: false,

          // Create body
          body: PageBackground(child: _buildPage(model)),

          // FAB
          floatingActionButton: Row(
            mainAxisAlignment: !model.isCurrentEditorsListValid()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: <Widget>[
              _addIdeaButton(),
              !model.isCurrentEditorsListValid()
                  ? Container(
                      width: 0.0,
                      height: 0.0,
                    )
                  : _finishButton(() => _finish(model))
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildPage(MainModel model) {
    return Center(
      child: !model.isCurrentEditorsListValid()
          ? EmptyScreenIcon(
              'No ideas yet?\n${model.randomIdea()}', CupertinoIcons.search)
          : ListView.builder(
              itemCount: model.getCurrentEditorsIdeasList().length,
              itemBuilder: (BuildContext context, int index) {
                return _makeCards(
                    model, model.getCurrentEditorsIdeasList()[index], index);
              },
            ),
    );
  }

  Widget _makeCards(MainModel model, String name, int index) {
    return Dismissible(
      key: Key(name),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          model.removeItemAt(index);
          setState(() {});
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(children: <Widget>[
          ListTile(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    name,
                    minFontSize: 20.0,
                    maxLines: 3,
                  )
                ]),
          ),
          ButtonBarTheme(
            data: const ButtonBarThemeData(),
            child: ButtonBar(children: <IconButton>[
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  model.removeItemAt(index);
                  setState(() {});
                },
              ),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _addIdeaButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Add More',
          backgroundColor: CupertinoColors.activeBlue,
          elevation: 0,
          child: const Icon(Icons.add, size: 30),
          onPressed: () {
            _showInput();
          },
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }

  Widget _finishButton(Function callback) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Continue',
          backgroundColor: CupertinoColors.activeBlue,
          elevation: 0,
          child: const Icon(
            CupertinoIcons.check_mark,
            size: 30,
          ),
          onPressed: callback,
        ),
        const SizedBox(
          height: 40.0,
        )
      ],
    );
  }

  void _finish(MainModel model) {
    if (model.isCurrentEditorsListValid()) {
      Navigator.pop(context);
    }
  }

  Future<void> _showInput() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return GestureDetector(
              // If the user taps outside form boxes then the keyboard is minimized
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                title: const Text('Date Ideas?'),
                content: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: 3,
                  controller: _textController,
                  autofocus: true,
                ),
                actions: <Widget>[
                  FlatButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    color: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      // Add the idea to the current editors list.
                      if (_textController.text.isNotEmpty) {
                        model.addIdea(_textController.text);

                        // Clear text from dialog.
                        // Otherwise text will remain next time.
                        _textController.text = '';

                        // Remove the dialog box.
                        Navigator.of(context, rootNavigator: true)
                            .pop('Continue');
                        setState(() {});
                      }
                    },
                  ),
                  FlatButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    color: Theme.of(context).primaryColor,
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('Discard');
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
