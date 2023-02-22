import 'package:auth/auth.dart';
import 'package:characters_package/characters.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt
    ..registerLazySingleton<IAuthRepository>(AuthRepository.new)
    ..registerLazySingleton<ICharactersRepository>(
      () => CharactersRepository(
        charactersService: getIt<ICharactersService>(),
      ),
    )
    ..registerLazySingleton<ICharactersService>(
      () => CharactersService(
        dio: getIt<Dio>(),
      ),
    )
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api/',
        ),
      ),
    );
}
