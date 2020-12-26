import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton(
      this.context, this.buttonName, this.isPersonListFull, this.callback);

  final BuildContext context;
  final String buttonName;
  final bool isPersonListFull;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        textStyle: const TextStyle(color: Colors.white),
        color: isPersonListFull ? Colors.red : Colors.greenAccent[700],
        child: InkWell(
          onTap: isPersonListFull ? null : callback,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isPersonListFull
                    ? const Icon(
                        Icons.person_add_disabled,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                Text(buttonName)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
