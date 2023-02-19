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
    try {
      final charactersDto = await _charactersService.getCharacters(page: page);
      try {
        final characters = charactersDto.map((e) => e.toModel()).toList();
        return Right(characters);
      } catch (e) {
        throw ModelException();
      }
    } catch (e) {
      return const Left(Failure.unknown());
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
