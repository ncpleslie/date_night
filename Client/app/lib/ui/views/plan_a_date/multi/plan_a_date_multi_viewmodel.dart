import 'package:date_night/app/locator.dart';
import 'package:date_night/app/router.gr.dart';
import 'package:date_night/enums/dialog_response_type.dart';
import 'package:date_night/enums/dialog_type.dart';
import 'package:date_night/services/plan_a_date_multi_service.dart';
import 'package:date_night/services/plan_a_date_single_service.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PlanADateMultiViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PlanADateMultiService _planADateMultiService = locator<PlanADateMultiService>();
  final PlanADateSingleService _planADateSingleService = locator<PlanADateSingleService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

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
      await _createARoomDialog();
      _planADateSingleService.clearAllSingleLists();
    } catch (e) {
      
      await _dialogService.showDialog(
          title: 'Unable to create a room',
          description:
              'Due to an unknown error we are unable to create a room.\nRestart the application and try again.');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _createARoomDialog() async {
    DialogResponse response = await _dialogService.showCustomDialog(
        title: 'Room Code',
        barrierDismissible: true,
        variant: DialogType.FormWithText,
        description: _planADateMultiService.roomId);

    if (response == null) {
      // Delete the room since the user has exited
      _planADateMultiService.deleteRoom();
      return;
    }

    if (response != null && response?.confirmed != null) {
      if (response.confirmed) {
        // Enter the room
        _planADateMultiService.isRoomHost = true;
        _planADateMultiService.isMultiEditing = true;
        _navigationService.navigateTo(Routes.addDateView);
      }

      if (!response.confirmed && response.responseData?.type == DialogResponseType.Copied) {
        // User wants to copy the room code
        Clipboard.setData(ClipboardData(text: roomId));
        _snackbarService.showSnackbar(title: 'Copied!', message: 'Room code copied to clipboard');

        // workaround to prevent the dialog from closing when tapping 'copy'
        await _createARoomDialog();
      }
    }
  }

  Future<void> enterARoom() async {
    _isLoading = true;
    notifyListeners();
    _planADateMultiService.clearAllMultiLists();

    DialogResponse response = await _dialogService.showCustomDialog(
        variant: DialogType.Form, title: 'Room Code', barrierDismissible: true, mainButtonTitle: 'Enter');

    if (response?.confirmed != null &&
        response.confirmed &&
        response?.responseData?.type == DialogResponseType.Text &&
        response?.responseData?.response != null) {
      String parsedString = response?.responseData?.response;
      bool isValidRoom = await _planADateMultiService.setARoom(parsedString);

      if (isValidRoom) {
        _planADateMultiService.isRoomHost = false;
        _planADateMultiService.isMultiEditing = true;
        _planADateSingleService.clearAllSingleLists();
        _navigationService.navigateTo(Routes.addDateView);

      } else {
        // Wrong room code
        await _dialogService.showCustomDialog(
            variant: DialogType.Basic,
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
    await _planADateMultiService
        .ideasHaveChanged((bool stateChanged) => {_ideasChanged = stateChanged, notifyListeners()});
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

  Future<bool> onPop() async {
    _planADateMultiService.clearAllMultiLists();
    _planADateMultiService.deleteRoom();
    return _navigationService.back();
  }
}
