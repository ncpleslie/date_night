import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_night/ui/views/plan_a_date/multi/plan_a_date_multi_viewmodel.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class PlanADateMultiView extends StatefulWidget {
  @override
  _PlanADateMultiViewState createState() => _PlanADateMultiViewState();
}

class _PlanADateMultiViewState extends State<PlanADateMultiView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanADateMultiViewModel>.reactive(
      viewModelBuilder: () => PlanADateMultiViewModel(),
      builder:
          (BuildContext context, PlanADateMultiViewModel vm, Widget child) =>
              Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          name: '',
          icon: Container(),
        ).build(context),
        body: PageBackground(
          child: Container(
            alignment: Alignment.center,
            child: vm.isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _button(
                          title: 'Create a room',
                          subtitle:
                              'Get a room code and share it with your friend.',
                          onPressed: () async => await vm.createARoom()),
                      _button(
                          title: 'Enter a room',
                          subtitle:
                              'If your friend has set up a room,\nenter their room code',
                          onPressed: () async => await vm.enterARoom()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _button(
      {@required String title,
      @required String subtitle,
      @required Function onPressed}) {
    return Container(
      height: 175, // Increase this to change the padding
      child: Stack(
        children: <Widget>[
          // Words in card
          Container(
            width: MediaQuery.of(context).size.width,
            height: 175.0,
            child: Card(
              elevation: Theme.of(context).cardTheme.elevation,
              shape: Theme.of(context).cardTheme.shape,
              color: Theme.of(context).cardTheme.color,
              margin: const EdgeInsets.all(20.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    primary:
                        Theme.of(context).primaryTextTheme.headline6?.color),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              title.toUpperCase(),
                              softWrap: true,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 1,
                              color: Colors.black38,
                            ),
                            AutoSizeText(
                              subtitle,
                              softWrap: true,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      _createChevron(context, onPressed)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createChevron(BuildContext context, Function onPressed) {
    final double buttonSize = 35;
    return Card(
      elevation: Theme.of(context).cardTheme.elevation,
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: InkWell(
          customBorder: new CircleBorder(),
          splashColor: Colors.black26,
          onTap: () => onPressed,
          onTapDown: (TapDownDetails details) {},
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxHeight: buttonSize,
                maxWidth: buttonSize,
                minHeight: buttonSize,
                minWidth: buttonSize),
            padding: EdgeInsets.all(0),
            child: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}
