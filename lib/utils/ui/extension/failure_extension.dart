import 'package:flutter/material.dart';

import '../../failure.dart';
import 'context_extension.dart';

extension FailureExtension on Failure {
  String getMessage(BuildContext context) => map(
        unknown: (value) => context.translation.upssSomethingWentWrong,
        noInternetConnection: (_) => context.translation.noInternetConnection,
        response: (response) => response.content,
      );
}
