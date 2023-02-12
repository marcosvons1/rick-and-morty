import 'package:auth/src/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String password,
  }) = _UserDto;

  factory UserDto.fromModel(User user) => UserDto(
        id: user.id,
        email: user.email,
        password: user.password,
      );

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  User toModel() => User(
        id: id,
        email: email,
        password: password,
      );
}
