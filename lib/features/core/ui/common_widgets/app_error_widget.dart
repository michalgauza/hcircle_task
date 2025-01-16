import 'package:flutter/material.dart';

import '../../../../utils/failure.dart';
import '../../../../utils/ui/extension/context_extension.dart';
import '../../../../utils/ui/extension/failure_extension.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.failure,
    this.retry,
    super.key,
  });

  final Failure failure;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(failure.getMessage(context)),
            if (retry != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: retry,
                  child: Text(context.translation.retry),
                ),
              ),
          ],
        ),
      );
}
