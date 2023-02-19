// ignore_for_file: public_member_api_docs

import 'package:characters_package/characters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Map<String, dynamic> origin,
    required Map<String, dynamic> location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
  }) = _Character;
}
