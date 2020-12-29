import 'package:model/main.dart';
import 'package:model/models/date_around_model.dart';
import 'package:date_night/src/widgets/empty_screen_icon.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dates_around_card.dart';

/// The list of Dates of other users.
// ignore: must_be_immutable
class DatesAroundListView extends StatefulWidget {
  DatesAroundListView({@required this.model});

  /// The Scoped model.
  MainModel model;

  @override
  State<StatefulWidget> createState() {
    return _DatesAroundListViewState();
  }
}

class _DatesAroundListViewState extends State<DatesAroundListView> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DateAroundModel>>(
      stream: widget.model.stream,
      builder: (BuildContext context,
          AsyncSnapshot<List<DateAroundModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(
            waterDropColor: Colors.deepPurple,
          ),
          footer:
              CustomFooter(builder: (BuildContext context, LoadStatus status) {
            return _loadingState(status);
          }),
          controller: refreshController,
          onRefresh: _refresh,
          onLoading: _loading,
          child: _list(context, snapshot),
        );
      },
    );
  }

  @override
  void initState() {
    widget.model.init();
    // Add Scroll listener to load more data
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        widget.model.loadMore();
      }
    });
    super.initState();
  }

  /// Creates the list of dates around.
  Widget _list(
      BuildContext context, AsyncSnapshot<List<DateAroundModel>> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      controller: scrollController,
      itemCount: snapshot.data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (snapshot.hasError || snapshot.data.isEmpty) {
          return _padding(
            const EmptyScreenIcon(
              'No Dates Found.',
              CupertinoIcons.refresh,
            ),
          );
        }
        if (index < snapshot.data.length) {
          return DatesAroundCard(
              date: snapshot.data[index], model: widget.model);
        }
        return Container();
      },
    );
  }

  /// What happens when the list is loading.
  Future<void> _loading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  /// The states the "Pull to refresh" Widget can have.
  Widget _loadingState(LoadStatus status) {
    switch (status) {
      case LoadStatus.loading:
        return _padding(const CupertinoActivityIndicator());
        break;

      case LoadStatus.failed:
        return _padding(const Text('Oops. Something went wrong.'));
        break;

      case LoadStatus.canLoading:
        return _padding(Text(
          EmojiParser().emojify(':ghost:'),
          style: const TextStyle(fontSize: 20.0),
        ));
        break;

      default:
        return _padding(const Text('No more for you'));
        break;
    }
  }

  /// Padding put around most elements of the list.
  Widget _padding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Center(
        child: child,
      ),
    );
  }

  /// Will refresh the list of dates.
  Future<void> _refresh() async {
    await widget.model.refresh();
    refreshController.refreshCompleted();
  }
}
