import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../utils/failure.dart';
import '../../../../domain/entity/movie_details.dart';

part 'movie_details_state.freezed.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.loaded(MovieDetails movieDetails) = _Loaded;

  const factory MovieDetailsState.loading() = _Loading;

  const factory MovieDetailsState.error(Failure failure) = _Error;
}
