import 'package:rick_and_morty_explorer/features/characters/presentation/favorite/cubit/favorit_cubit.dart';

import 'di_ex.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {
  /// Network services
  di.registerSingleton<Dio>(Dio());

  /// Helper
  di.registerSingleton(InternetConnectionHelper());

  /// Hive DataBase
  await Hive.initFlutter();

  /// DB Services
  // Home DataBase Service
  di.registerSingleton(DataBaseService());
  await di<DataBaseService>().initDataBase();

  /// Api Providers
  di.registerSingleton(ApiImpl(di<Dio>()));

  /// DataBase Providers
  // Home
  di.registerSingleton(DataBaseProvider(
    dataBaseService: di<DataBaseService>(),
  ));

  /// Repository
  // Home
  di.registerSingleton(CharacterRepositoryImpl(
    di<ApiImpl>(),
    di<DataBaseProvider>(),
  ));

  /// Blocs
  // Home
  di.registerSingleton<CharacterPageCubit>(
      CharacterPageCubit(di<CharacterRepositoryImpl>()));
  di.registerSingleton<FavoritCubit>(
      FavoritCubit(di<CharacterRepositoryImpl>()));
}
