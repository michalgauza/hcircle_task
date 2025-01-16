import 'package:freezed_annotation/freezed_annotation.dart';

part 'genres.freezed.dart';

@freezed
class Genres with _$Genres {
  const factory Genres({
    required int id,
    required String name,
  }) = _Genres;
}
