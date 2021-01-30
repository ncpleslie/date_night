import 'package:auto_size_text/auto_size_text.dart';
import 'package:model/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The date idea cards that are listed on the "Add Date" page.
/// Makes each card for a chosen idea input by the user.
/// The card can also be dismissed or deleted.
class DateAddIdeaCard extends StatelessWidget {
  const DateAddIdeaCard(
      {@required this.model,
      @required this.name,
      @required this.index,
      @required this.onDelete});

  /// Main model
  final MainModel model;

  /// Name of the card.
  final String name;

  /// Index of the item.
  final int index;

  /// What to call when the user deletes the card.
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(name),
      background: Container(
        padding: const EdgeInsets.only(right: 20.0),
        width: MediaQuery.of(context).size.width / 2,
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDelete(model, index),
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
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ]),
          ),
          ButtonBarTheme(
            data: const ButtonBarThemeData(),
            child: ButtonBar(children: <IconButton>[
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: Theme.of(context).primaryIconTheme.size,
                ),
                onPressed: () => onDelete(model, index),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
