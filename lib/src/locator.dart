import 'package:get_it/get_it.dart';

import '../src/core/services/dialog/dialog_service.dart';
import 'core/repositories/user/user_repository.dart';
import 'core/repositories/user/user_repository_impl.dart';
import 'core/services/device_info/device_info.dart';
import 'core/services/device_info/device_info_impl.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
Future<void> setupLocator() async {
  // Services

  /// UserRepository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );
  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );
  locator.registerLazySingleton<DeviceInfoService>(
    () => DeviceInfoServiceImpl(),
  );
}
