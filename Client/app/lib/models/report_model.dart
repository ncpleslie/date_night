import 'package:flutter/material.dart';

class ReportModel {
  ReportModel({@required this.dateAroundId});

  final String dateAroundId;

  Map<String, dynamic> toJson() => {'dateAroundId': dateAroundId};
}
