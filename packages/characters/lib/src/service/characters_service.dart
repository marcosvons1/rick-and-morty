// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ICharactersService {
  Future<List<CharacterDto>> getCharacters({required int page});
  Future<LocationDto> getLocation({required String locationUrl});
  Future<EpisodeDto> getEpisode({required String episodeId});
  Future<Unit> setCharacterAsFavorite({required Character character});
  Future<Unit> removeCharacterFromFavorites({required int characterId});
}

class CharactersService implements ICharactersService {
  CharactersService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<CharacterDto>> getCharacters({int page = 1}) async {
    final Response<Map<String, dynamic>> response;

    try {
      response = await _dio.get(
        'character/?page=$page',
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw ConnectionErrorException();
      } else if (e.type == DioErrorType.connectTimeout) {
        throw TimeoutException();
      } else {
        throw UnknownNetworkException();
      }
    }

    try {
      final responseData = response.data as Map<String, dynamic>;
      final charactersDto = (responseData['results'] as List)
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

  @override
  Future<EpisodeDto> getEpisode({required String episodeId}) async {
    Response<Map<String, dynamic>> response;

    try {
      final url = '${_dio.options.baseUrl}episode/$episodeId';
      response = await _dio.get(
        'episode/$episodeId',
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw ConnectionErrorException();
      } else if (e.type == DioErrorType.connectTimeout) {
        throw TimeoutException();
      } else {
        print(e);
        throw UnknownNetworkException();
      }
    }

    try {
      final episodeDto =
          EpisodeDto.fromJson(response.data as Map<String, dynamic>);

      return episodeDto;
    } catch (e) {
      throw JsonDeserializationException();
    }
  }

  @override
  Future<LocationDto> getLocation({required String locationUrl}) async {
    Response response;

    try {
      response = await _dio.get(
        'location/$locationUrl',
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw ConnectionErrorException();
      } else if (e.type == DioErrorType.connectTimeout) {
        throw TimeoutException();
      } else {
        throw UnknownNetworkException();
      }
    }

    try {
      final locationDto =
          LocationDto.fromJson(response.data as Map<String, dynamic>);
      return locationDto;
    } catch (e) {
      throw JsonDeserializationException();
    }
  }
}
