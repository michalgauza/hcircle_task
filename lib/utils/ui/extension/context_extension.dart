import 'package:flutter/material.dart';

import '../../failure.dart';
import '../translations/generated/l10n.dart';
import 'failure_extension.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  void showErrorSnackBar(
    Failure failure, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          actionOverflowThreshold: 1,
          duration: duration,
          action: action,
          content: Text(
            failure.getMessage(this),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );

  Translation get translation => Translation.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
