import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_model/ideas_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/dates_around.dart';
import '../../widgets/empty_screen_icon.dart';
import '../../widgets/page_background.dart';

/// Dates Around displays the winning date idea of other users
/// along with their non-winning ideas.
/// This screen will pull these ideas from the DB and display
/// them in a list of cards.
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
          appBar: CustomAppBar('Dates Around You', _refreshPageIcon())
              .build(context),
          body: PageBackground(child: _buildDateIdeasList()),
        );
      },
    );
  }

  Widget _refreshPageIcon() {
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
        children: const <Widget>[
          Center(
            child: EmptyScreenIcon(
              'No Dates Found',
              Icon(CupertinoIcons.search),
            ),
          ),
        ],
      ),
    );
  }
}
