
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/errors/error_handler.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/core/shared/models/version_model.dart';
import 'package:mk_academy/core/shared/repos/app_version/pay_repo.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

import 'app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  final AppVersionRepo _appVersionRepo;

  AppVersionCubit(this._appVersionRepo) : super(AppVersionInitial());

  Future<void> checkAppVersion(BuildContext context) async {
    emit(AppVersionLoading());

    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;
      // log("The version is: $currentVersion");

      final Either<Failure, VersionModel> result =
          await _appVersionRepo.getVersionFromApi();

      result.fold(
        (failure) {
          emit(AppVersionError(failure.message));
        },
        (version) {
          final String? min = version.minRequiredVersion;
          final String? max = version.maxVersion;
          // log("The min: $min | The current: $currentVersion | The max: $max");

          if (min == null || max == null) {
            emit(AppVersionError("error_description_fallback".tr(context)));
            return;
          }

          if (_isVersionOutdated(currentVersion, min)) {
            emit(AppVersionOutdated(version: version));
          } else if (_isVersionInRange(currentVersion, min, max)) {
            emit(AppVersionUnsupported(version: version));
          } else {
            emit(AppVersionInRange());
          }
        },
      );
    } catch (e) {
      emit(AppVersionError(ErrorHandler.defaultMessage()));
    }
  }

  bool _isVersionInRange(
      String currentVersion, String minVersion, String maxVersion) {
    final Version current = Version.parse(currentVersion);
    final Version min = Version.parse(minVersion);
    final Version max = Version.parse(maxVersion);
    return min <= current && current < max;
  }

  bool _isVersionOutdated(String currentVersion, String minVersion) {
    final Version current = Version.parse(currentVersion);
    final Version min = Version.parse(minVersion);
    return current < min;
  }
}
