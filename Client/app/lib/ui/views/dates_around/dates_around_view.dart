import 'package:date_night/models/date_around_model.dart';
import 'package:date_night/ui/widgets/dumb_widgets/custom_app_bar.dart';
import 'package:date_night/ui/widgets/dumb_widgets/empty_screen_icon.dart';
import 'package:date_night/ui/widgets/dumb_widgets/page_background.dart';
import 'package:date_night/ui/widgets/dumb_widgets/shimmer_dates_around_listview.dart';
import 'package:date_night/ui/widgets/smart_widgets/dates_around_card/dates_around_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:stacked/stacked.dart';

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
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  var title = 'Dates Around';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatesAroundViewModel>.reactive(
      onModelReady: (model) => onModelReady(model),
      viewModelBuilder: () => DatesAroundViewModel(),
      builder: (BuildContext context, DatesAroundViewModel model, Widget child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
                  name: title,
                  icon: _settingsIcon(context, model),
                  transparent: true,
                  scrollable: true,
                  scrollController: controller)
              .build(context),
          body: PageBackground(
            child: model.isBusy
                ? ShimmerDatesAroundListView()
                : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropHeader(
                        waterDropColor: Theme.of(context).primaryColor,
                      ),
                      footer: CustomFooter(builder: (BuildContext context, LoadStatus status) {
                        return _loadingState(status);
                      }),
                      controller: refreshController,
                      onRefresh: () async => {
                        await model.loadMore(clearCacheData: true),
                        refreshController.refreshCompleted(),
                        //controller.appBar.setPinState(true),
                      },
                      onLoading: () => refreshController.loadComplete(),
                      child: !model.hasError && model.dataReady
                          ? _list(context, model.dates)
                          : EmptyScreenIcon('Failed to load.\nPull down to refresh.'),
                    ),
                ),
          ),
        );
      },
    );
  }

  void onModelReady(DatesAroundViewModel model) {
    // Add Scroll listener to load more data
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        model.loadMore();
        //controller.appBar.setPinState(false);
      }
    });
  }

  /// Creates the list of dates around.
  Widget _list(BuildContext context, List<DateAroundModel> dates) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 45.0),
      controller: controller,
      itemCount: dates.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < dates.length) {
          return DatesAroundCard(id: dates[index].id, date: dates[index], index: index);
        }
        return Container();
      },
    );
  }

  /// The states the "Pull to refresh" Widget can have.
  Widget _loadingState(LoadStatus status) {
    switch (status) {
      case LoadStatus.loading:
        return ShimmerDatesAroundListView();
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

  /// The settings icon display in the AppBar.
  /// Will take the user to the settings page.
  Widget _settingsIcon(BuildContext context, DatesAroundViewModel model) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: model.navigateToSettings,
    );
  }
}
