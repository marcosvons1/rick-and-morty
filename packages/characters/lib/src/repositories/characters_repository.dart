// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ICharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters({required int page});
  Either<Failure, Unit> setCharacterAsFavorite({required Character character});
  Either<Failure, Unit> removeCharacterFromFavorites({
    required int characterId,
  });
}

class CharactersRepository implements ICharactersRepository {
  CharactersRepository({required ICharactersService charactersService})
      : _charactersService = charactersService;

  final ICharactersService _charactersService;

  @override
  Future<Either<Failure, List<Character>>> getCharacters({
    required int page,
  }) async {
    final characters = <Character>[];
    LocationDto? locationDto;
    LocationDto? originDto;
    final episodes = <EpisodeDto>[];

    try {
      final charactersDto = await _charactersService.getCharacters(page: page);
      for (final characterDto in charactersDto) {
        for (final episodeUrl in characterDto.episode) {
          try {
            final episode = await _charactersService.getEpisode(
              episodeId: episodeUrl.substring(episodeUrl.lastIndexOf('/') + 1),
            );

            episodes.add(episode);
          } catch (e) {
            continue;
          }
        }
        if (characterDto.location['url']!.isNotEmpty) {
          locationDto = await _charactersService.getLocation(
            locationUrl: characterDto.location['url']!
                .substring(characterDto.location['url']!.lastIndexOf('/') + 1),
          );
        }
        if (characterDto.origin['url']!.isNotEmpty) {
          originDto = await _charactersService.getLocation(
            locationUrl: characterDto.origin['url']!
                .substring(characterDto.origin['url']!.lastIndexOf('/') + 1),
          );
        }
        characters.add(
          characterDto.toModel(
            episodes: episodes,
            location: locationDto,
            origin: originDto,
          ),
        );
        episodes.clear();
      }

      return Right(characters);
    } on ConnectionErrorException {
      return const Left(Failure.http());
    } on TimeoutException {
      return const Left(Failure.connectTimeout());
    } on UnknownNetworkException {
      return const Left(Failure.unknown());
    } on JsonDeserializationException {
      return const Left(Failure.jsonDes());
    } catch (e) {
      return const Left(Failure.parseModel());
    }
  }

  @override
  Either<Failure, Unit> removeCharacterFromFavorites({
    required int characterId,
  }) {
    // TODO: implement removeCharacterFromFavorites
    throw UnimplementedError();
  }

  @override
  Either<Failure, Unit> setCharacterAsFavorite({required Character character}) {
    // TODO: implement setCharacterAsFavorite
    throw UnimplementedError();
  }
}
