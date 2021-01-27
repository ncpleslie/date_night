import 'package:date_night/src/routes/routes.dart';
import 'package:date_night/src/widgets/custom_app_bar.dart';
import 'package:date_night/src/widgets/dates_around_card.dart';
import 'package:date_night/src/widgets/dates_around_listview.dart';
import 'package:date_night/src/widgets/empty_screen_icon.dart';
import 'package:date_night/src/widgets/page_background.dart';
import 'package:date_night/src/widgets/shimmer_dates_around_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import 'dates_around_model.dart';
import 'dates_around_viewmodel.dart';

/// Dates Around displays the winning date idea of other users
/// along with their non-winning ideas.
/// This screen will pull these ideas from the DB and display
/// them in a list of cards.
class DatesAroundView extends StatefulWidget {
  DatesAroundView({Key key}) : super(key: key);

  @override
  _DatesAroundViewState createState() => _DatesAroundViewState();
}

class _DatesAroundViewState extends State<DatesAroundView> {
  final ScrollController controller = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatesAroundViewModel>.reactive(
      viewModelBuilder: () => DatesAroundViewModel(),
      builder:
          (BuildContext context, DatesAroundViewModel model, Widget child) =>
              Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
                name: 'Dates Around',
                icon: _settingsIcon(context),
                transparent: true,
                scrollable: true,
                scrollController: controller)
            .build(context),
        body: PageBackground(
            child: StreamBuilder<List<DateAroundModel>>(
          stream: model.stream,
          builder: (BuildContext context,
              AsyncSnapshot<List<DateAroundModel>> snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return ShimmerDatesAroundListView();
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                waterDropColor: Theme.of(context).primaryColor,
              ),
              footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus status) {
                return _loadingState(status);
              }),
              controller: refreshController,
              onRefresh: () async => {
                await model.refresh(),
                refreshController.refreshCompleted(),
              },
              onLoading: _loading,
              child: !snapshot.hasError
                  ? _list(context, snapshot)
                  : EmptyScreenIcon('Failed to load.\nPull down to refresh.'),
            );
          },
        )

            // DatesAroundListView(
            //   controller: controller,
            //   model: model,
            // ),
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Add Scroll listener to load more data
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        // model.loadMore();
      }
    });
  }

  /// Creates the list of dates around.
  Widget _list(
      BuildContext context, AsyncSnapshot<List<DateAroundModel>> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      controller: controller,
      itemCount: snapshot.data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (snapshot.hasError || snapshot.data.isEmpty) {
          return EmptyScreenIcon(
            'No Dates Found. Pull down to refresh',
          );
        }
        if (index < snapshot.data.length) {
          return DatesAroundCard(
              id: snapshot.data[index].id,
              date: snapshot.data[index],
              // model: widget.model,
              index: index);
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
        return _padding(Text(
          '',
          style: Theme.of(context).primaryTextTheme.subtitle1,
        ));
        break;
    }
  }

  /// Padding put around most elements of the list.
  Widget _padding(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: child,
      ),
    );
  }

  // /// Will refresh the list of dates.
  // Future<void> _refresh() async {
  //   await model.refresh();
  //   refreshController.refreshCompleted();
  // }

  /// The settings icon display in the AppBar.
  /// Will take the user to the settings page.
  Widget _settingsIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () => Navigator.of(context).pushNamed(Routes.Settings),
    );
  }
}
