import 'package:freezed_annotation/freezed_annotation.dart';

import '../../failure.dart';

part 'pagination_state.freezed.dart';

@freezed
class PaginationState with _$PaginationState {
  const factory PaginationState.idle() = _PaginationIdle;

  const factory PaginationState.end() = _PaginationEnd;

  const factory PaginationState.loading() = _PaginationLoading;

  const factory PaginationState.error(Failure failure) = _PaginationError;
}
