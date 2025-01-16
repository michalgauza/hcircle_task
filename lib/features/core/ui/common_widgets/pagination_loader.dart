import 'package:flutter/material.dart';

import '../../../../utils/ui/pagination/pagination_state.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader(this.paginationState, {super.key});

  final PaginationState paginationState;

  @override
  Widget build(BuildContext context) => paginationState.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        loading: () => const Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
