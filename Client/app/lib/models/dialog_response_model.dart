import 'package:date_night/enums/dialog_response_type.dart';

class CustomDialogResponse {
  DialogResponseType type;
  String? response;

  CustomDialogResponse({required this.type, this.response});
}