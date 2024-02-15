import 'package:get_it/get_it.dart';
import 'package:van_gogh/controllers/houses_controller.dart';
import 'package:van_gogh/repositories/holders_repository.dart';
import 'package:van_gogh/repositories/houses_repository.dart';
import 'package:van_gogh/repositories/payments_repository.dart';
import 'package:van_gogh/services/auth_service.dart';

final getIt = GetIt.instance;

setupProviders() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt
      .registerLazySingleton<HoldersRepository>(() => LocalHoldersRepository());
  getIt.registerLazySingleton<PaymentsRepository>(
      () => LocalPaymentsRepository());
  getIt.registerLazySingleton<HousesRepository>(
    () => LocalHousesRepository(
      holdersRepository: getIt<HoldersRepository>(),
      paymentsRepository: getIt<PaymentsRepository>(),
    ),
  );
  getIt.registerLazySingleton<HousesController>(
    () => HousesController(housesRepository: getIt<HousesRepository>()),
  );
}
