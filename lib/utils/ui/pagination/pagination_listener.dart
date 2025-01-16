import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import 'pagination_helper.dart';
import 'pagination_state.dart';

mixin PaginationListener {
  void paginationListener({
    required PaginationState paginationState,
    required ScrollController scrollController,
    required PaginationHelper paginationHelper,
    required BuildContext context,
  }) {
    paginationState.whenOrNull(
      error: (failure) => context.showErrorSnackBar(
        failure,
        // Show snack bar all te time when error occurs so user can retry
        duration: const Duration(days: 365),
        action: SnackBarAction(
          label: context.translation.retry,
          onPressed: paginationHelper.retryFetch,
        ),
      ),
      idle: () {
        scrollController.addListener(
          () {
            final sPosition = scrollController.position;
            if (sPosition.pixels >= sPosition.maxScrollExtent - 10) {
              paginationHelper.fetchNext();
            }
          },
        );
      },
    );
  }
}
