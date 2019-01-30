import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/ideas_model.dart';

import '../../widgets/dates_around.dart';

class DatesAroundPage extends StatefulWidget {
  final IdeasModel model;

  DatesAroundPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundPageState();
  }
}

class _DatesAroundPageState extends State<DatesAroundPage> {
  Future dateList;

  @override
  void initState() {
    super.initState();
    dateList = widget.model.fetchDateIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBackgroundWithBody(),
        );
      },
    );
  }

  Widget _buildBackgroundWithBody() {
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

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
        title: Text('Dates Around You'),
        backgroundColor: Colors.deepPurple,
        toolbarOpacity: 0.7,
        elevation: 0,
        actions: <Widget>[
          _refreshPage(),
        ],
      ),
    );
  }

  Widget _refreshPage() {
    return IconButton(
      icon: Icon(CupertinoIcons.refresh),
      tooltip: 'Refresh',
      onPressed: () async {
        widget.model.dateIdeasList.clear();
        widget.model.clearLastVisible();
        widget.model.clearAllLists();
        await widget.model.fetchDateIdeas();
      },
    );
  }

  Widget _buildDateIdeasList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        Widget content = _noItemsLoaded();
        if (model.displayedIdeas.length > 0 && !model.isLoading) {
          content = DatesAround(model, dateList);
        } else if (model.isLoading) {
          content = Container();
        }
        return RefreshIndicator(
          child: content,
          onRefresh: () async {
            widget.model.dateIdeasList.clear();
            widget.model.clearLastVisible();
            widget.model.clearAllLists();
            await widget.model.fetchDateIdeas();
          },
        );
      },
    );
  }

  Widget _noItemsLoaded() {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Icon(CupertinoIcons.search),
                Text('No Dates Found'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
