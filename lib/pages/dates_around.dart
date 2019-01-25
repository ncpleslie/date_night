import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/ideas_model.dart';

import '../widgets/dates_around.dart';

class DatesAroundPage extends StatefulWidget {
  final IdeasModel model;

  DatesAroundPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundPageState();
  }
}

class _DatesAroundPageState extends State<DatesAroundPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    widget.model.fetchDateIdeas();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Scaffold(appBar: _buildAppBar(model), body: _buildBackground());
      },
    );
  }

  Widget _buildBackground() {
    Color gradientStart = Colors.deepPurple[700];
    Color gradientEnd = Colors.purple[500];

    return Container(
      child: _buildDateIdeasList(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.5),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            colors: [gradientStart, gradientEnd],
            tileMode: TileMode.clamp),
      ),
    );
  }

  Widget _buildAppBar(model) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      toolbarOpacity: 0.7,
      elevation: 0,
      actions: <Widget>[
        _refreshPage(model),
      ],
    );
  }

  Widget _refreshPage(model) {
    return IconButton(
      icon: Icon(CupertinoIcons.refresh),
      tooltip: 'Refresh',
      onPressed: () {
        _refreshIndicatorKey.currentState.show();
        model.fetchDateIdeas();
      },
    );
  }

  Widget _buildDateIdeasList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        Widget content = Center(child: Text('No Other Dates Found'));
        if (model.displayedIdeas.length > 0 && !model.isLoading) {
          content = DatesAround();
        } else if (model.isLoading) {
          content = Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          child: content,
          onRefresh: model.fetchDateIdeas,
        );
      },
    );
  }
}
