// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICharactersService {
  Future<List<CharacterDto>> getCharacters({required int page});
  Future<Unit> setCharacterAsFavorite({required Character character});
  Future<Unit> removeCharacterFromFavorites({required int characterId});
}

class CharactersService implements ICharactersService {
  CharactersService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<CharacterDto>> getCharacters({int page = 1}) async {
    Response response;

    try {
      response = await _dio.get(
        'character/?page=$page',
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        throw ConnectionErrorException();
      } else if (e.type == DioErrorType.connectionTimeout) {
        throw TimeoutException();
      } else {
        throw UnknownNetworkException();
      }
    }

    try {
      final charactersDto = (response.data['results'] as List)
          .map(
            (dynamic character) =>
                CharacterDto.fromJson(character as Map<String, dynamic>),
          )
          .toList();
      return charactersDto;
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  @override
  Future<Unit> removeCharacterFromFavorites({required int characterId}) {
    // TODO: implement removeCharacterFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<Unit> setCharacterAsFavorite({required Character character}) {
    // TODO: implement setCharacterAsFavorite
    throw UnimplementedError();
  }
}
