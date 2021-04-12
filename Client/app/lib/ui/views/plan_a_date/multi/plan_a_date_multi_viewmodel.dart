import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/enums/dialog_type.dart';
import 'package:date_night/services/plan_a_date_multi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PlanADateMultiViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateMultiService _planADateMultiService =
      locator<PlanADateMultiService>();

  bool get isRoomHost => _planADateMultiService.isRoomHost;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _ideasChanged = false;
  bool get ideasChanged => _ideasChanged;

  String get roomId => _planADateMultiService.roomId;

  Future<void> createARoom() async {
    _planADateMultiService.clearAllMultiLists();
    _isLoading = true;
    notifyListeners();

    try {
      await _planADateMultiService.getARoom();
      DialogResponse response = await _dialogService.showDialog(
          title: 'Room Code', description: _planADateMultiService.roomId);

      if (response.confirmed != null && response.confirmed) {
        _planADateMultiService.isRoomHost = true;
        _planADateMultiService.isMultiEditing = true;
        _navigationService.navigateTo(Routes.addDateView);
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Unable to create a room',
          description:
              'Due to an unknown error we are unable to create a room.\nRestart the application and try again.');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> enterARoom() async {
    // TODO: Style Dialog
    DialogResponse response = await _dialogService.showCustomDialog(
        title: 'Room ID', variant: DialogType.Form, mainButtonTitle: 'Enter');

    _planADateMultiService.clearAllMultiLists();
    _isLoading = true;
    notifyListeners();

    if (response?.responseData[0] != null) {
      String parsedString = response?.responseData[0];
      bool isValidRoom = await _planADateMultiService.setARoom(parsedString);

      if (isValidRoom) {
        _planADateMultiService.isRoomHost = false;
        _planADateMultiService.isMultiEditing = true;
        _navigationService.navigateTo(Routes.addDateView);
      } else {
        // TODO: Style Dialog
        await _dialogService.showDialog(
            title: 'Unable to enter that room',
            description: 'Are you sure that\'s the right room code?');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> commitMultiIdeas() async {
    await _planADateMultiService.commitMultiIdeas();
  }

  /// Determine if the other users have added their picks
  Future<void> ideasHaveChanged() async {
    await _planADateMultiService.ideasHaveChanged((bool stateChanged) =>
        {_ideasChanged = stateChanged, notifyListeners()});
  }

  /// Wait for the host to move on to display the results
  Future<void> waitForHost() async {
    await _planADateMultiService.waitForHost();
    await navigateToLoading();
  }

  Future<void> navigateToLoading() async {
    await _navigationService.replaceWith(Routes.loadingView);
  }

  Future<void> init() async {
    if (isRoomHost) {
      await commitMultiIdeas();
      await ideasHaveChanged();
    } else {
      await commitMultiIdeas();
      await waitForHost();
    }
  }
}
