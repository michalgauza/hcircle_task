import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.unknown() = _Unknown;

  const factory Failure.noInternetConnection() = _NoInternetConnection;

  const factory Failure.response(String content) = _Response;
}
