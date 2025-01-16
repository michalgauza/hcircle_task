import 'package:flutter/material.dart';

import '../../../features/core/ui/pages/popular_movies_page/cubit/popular_movies_cubit.dart';

mixin PaginationListener {
  void paginationListener({
    required PaginationState paginationState,
    required ScrollController scrollController,
    required PaginationHelper paginationHelper,
    required BuildContext context,
  }) {
    paginationState.whenOrNull(
      error: (failure) => context.showErrorSnackBar(failure),
      initial: () {
        scrollController.addListener(
              () {
            if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 10) {
              paginationHelper.fetchNext();
            }
          },
        );
      },
    );
  }
}