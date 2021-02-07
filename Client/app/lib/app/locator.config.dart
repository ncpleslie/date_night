// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/dates_around_service.dart';
import '../services/plan_a_date_single_service.dart';
import '../services/random_idea_service.dart';
import '../services/result_feedback_service.dart';
import '../services/startup_service.dart';
import '../services/third_party_services_module.dart';
import '../services/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<DatesAroundService>(() => DatesAroundService());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<PlanADateSingleService>(() => PlanADateSingleService());
  gh.lazySingleton<RandomIdeaService>(() => RandomIdeaService());
  gh.lazySingleton<ResultFeedbackService>(() => ResultFeedbackService());
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<StartUpService>(() => StartUpService());
  gh.lazySingleton<UserService>(() => UserService());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
