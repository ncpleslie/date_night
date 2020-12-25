import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/ideas_model.dart';
import '../../widgets/dates_around.dart';

class DatesAroundPage extends StatefulWidget {
  const DatesAroundPage(this.model);
  final IdeasModel model;

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundPageState();
  }
}

class _DatesAroundPageState extends State<DatesAroundPage> {
  Future<List<dynamic>> dateList;

  @override
  void initState() {
    super.initState();
    dateList = widget.model.fetchDateIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBackgroundWithBody(),
        );
      },
    );
  }

  Widget _buildBackgroundWithBody() {
    final Color gradientStart = Colors.deepPurple[700];
    final Color gradientEnd = Colors.purple[500];
    return Container(
      child: _buildDateIdeasList(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.5),
            end: const FractionalOffset(0.5, 0.0),
            stops: const <double>[0.0, 1.0],
            colors: <Color>[gradientStart, gradientEnd],
            tileMode: TileMode.clamp),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: AppBar(
        title: const Text('Dates Around You'),
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
      icon: const Icon(CupertinoIcons.refresh),
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
    return ScopedModelDescendant<IdeasModel>(
      builder: (BuildContext context, Widget child, IdeasModel model) {
        Widget content = _noItemsLoaded();
        if (model.displayedIdeas.isNotEmpty) {
          content = model.isLoading
              ? Stack(
                  children: <Widget>[
                    DatesAround(model, dateList),
                    LinearProgressIndicator(
                      backgroundColor: Colors.deepPurple[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.deepPurple),
                    )
                  ],
                )
              : DatesAround(model, dateList);
        } else if (model.isLoading) {
          content = Container(
            child: const Center(
              child: Text('Loading...'),
            ),
          );
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
              children: const <Widget>[
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
