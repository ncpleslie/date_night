// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i5;

import '../services/api_service.dart' as _i3;
import '../services/dates_around_service.dart' as _i4;
import '../services/plan_a_date_base_service.dart' as _i6;
import '../services/plan_a_date_multi_service.dart' as _i7;
import '../services/plan_a_date_single_service.dart' as _i8;
import '../services/random_idea_service.dart' as _i9;
import '../services/realtime_db_service.dart' as _i10;
import '../services/result_feedback_service.dart' as _i11;
import '../services/startup_service.dart' as _i12;
import '../services/third_party_services_module.dart' as _i14;
import '../services/user_service.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
  gh.lazySingleton<_i4.DatesAroundService>(() => _i4.DatesAroundService());
  gh.lazySingleton<_i5.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i5.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i6.PlanADateBaseService>(() => _i6.PlanADateBaseService());
  gh.lazySingleton<_i7.PlanADateMultiService>(
      () => _i7.PlanADateMultiService());
  gh.lazySingleton<_i8.PlanADateSingleService>(
      () => _i8.PlanADateSingleService());
  gh.lazySingleton<_i9.RandomIdeaService>(() => _i9.RandomIdeaService());
  gh.lazySingleton<_i10.RealtimeDBService>(() => _i10.RealtimeDBService());
  gh.lazySingleton<_i11.ResultFeedbackService>(
      () => _i11.ResultFeedbackService());
  gh.lazySingleton<_i5.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i12.StartUpService>(() => _i12.StartUpService());
  gh.lazySingleton<_i13.UserService>(() => _i13.UserService());
  return get;
}

class _$ThirdPartyServicesModule extends _i14.ThirdPartyServicesModule {
  @override
  _i5.DialogService get dialogService => _i5.DialogService();
  @override
  _i5.NavigationService get navigationService => _i5.NavigationService();
  @override
  _i5.SnackbarService get snackbarService => _i5.SnackbarService();
}
